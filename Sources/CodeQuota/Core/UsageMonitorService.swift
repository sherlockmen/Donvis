import Foundation
import OSLog
import ServiceManagement

@MainActor
final class UsageMonitorService: ObservableObject {
    @Published private(set) var snapshots: [ProviderType: UsageSnapshot] = [:]
    @Published private(set) var activeProviders = Set<ProviderType>()
    @Published private(set) var selectedProvider: ProviderType?
    @Published private(set) var hasCompletedInitialCheck = false
    @Published private(set) var isRefreshing = false
    @Published var errorMessage: String?
    @Published var launchAtLoginError: String?

    let settings: AppSettings
    private let codex: CodexProvider
    private let claude: ClaudeCodeProvider
    private let detector: ClientActivityDetector
    private let cache: UsageCacheStoring
    private let notifications: NotificationService
    private let logger = Logger(subsystem: "com.codequota.app", category: "monitor")
    private var timerTask: Task<Void, Never>?
    private var lastUsageRefresh = Date.distantPast
    private var activityDates: [ProviderType: Date] = [:]

    init(
        settings: AppSettings = .init(),
        codex: CodexProvider = .init(),
        claude: ClaudeCodeProvider = .init(),
        detector: ClientActivityDetector = .init(),
        cache: UsageCacheStoring = UsageCacheStore(),
        notifications: NotificationService = .init()
    ) {
        self.settings = settings
        self.codex = codex
        self.claude = claude
        self.detector = detector
        self.cache = cache
        self.notifications = notifications
        ProviderType.allCases.forEach { provider in
            if let cached = cache.load(provider) { snapshots[provider] = cached }
        }
    }

    func start() {
        if settings.notificationsEnabled { notifications.requestAuthorization() }
        timerTask?.cancel()
        timerTask = Task {
            await refresh()
            hasCompletedInitialCheck = true
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                await detectActivity()
                if !activeProviders.isEmpty, Date().timeIntervalSince(lastUsageRefresh) >= 60 {
                    await refreshUsage()
                }
            }
        }
    }

    func stop() { timerTask?.cancel() }

    func refresh() async {
        guard !isRefreshing else { return }
        isRefreshing = true
        defer { isRefreshing = false }
        await detectActivity()
        await refreshUsage()
    }

    func setLaunchAtLogin(_ enabled: Bool) {
        do {
            if enabled { try SMAppService.mainApp.register() } else { try SMAppService.mainApp.unregister() }
            launchAtLoginError = nil
        } catch {
            launchAtLoginError = "登录时启动需要从标准签名 App bundle 运行。\(error.localizedDescription)"
        }
    }

    var launchAtLoginEnabled: Bool { SMAppService.mainApp.status == .enabled }
    var claudeBridgeInstalled: Bool { claude.isBridgeInstalled }
    var activeProvider: ProviderType? { selectedProvider.flatMap { activeProviders.contains($0) ? $0 : nil } }
    var activeSnapshot: UsageSnapshot? { activeProvider.flatMap { snapshots[$0] } }

    func isStale(_ provider: ProviderType) -> Bool {
        snapshots[provider].map { cache.isStale($0, now: Date()) } ?? false
    }

    private func detectActivity() async {
        let activity = await detector.detect()
        activeProviders = activity.activeProviders
        activityDates.merge(activity.activityDates) { max($0, $1) }
        if let current = selectedProvider, activeProviders.contains(current) {
            if let newer = mostRecentlyActiveProvider(), newer != current,
               activitySignal(for: newer) > activitySignal(for: current) {
                selectedProvider = newer
            }
        } else {
            selectedProvider = mostRecentlyActiveProvider()
        }
    }

    private func refreshUsage() async {
        guard !activeProviders.isEmpty else { return }
        for provider in activeProviders {
            await refresh(provider: provider == .codex ? codex : claude)
        }
        lastUsageRefresh = Date()
        selectedProvider = mostRecentlyActiveProvider() ?? selectedProvider
    }

    private func refresh(provider: UsageProvider) async {
        do {
            let snapshot = try await provider.fetchUsage()
            snapshots[snapshot.provider] = snapshot
            cache.save(snapshot)
            if settings.notificationsEnabled { notifications.evaluate(snapshot) }
            errorMessage = nil
        } catch {
            logger.error("Provider refresh failed: \(error.localizedDescription, privacy: .public)")
            errorMessage = error.localizedDescription
        }
    }

    private func mostRecentlyActiveProvider() -> ProviderType? {
        activeProviders.max { activitySignal(for: $0) < activitySignal(for: $1) }
    }

    private func activitySignal(for provider: ProviderType) -> Date {
        max(activityDates[provider] ?? .distantPast, snapshots[provider]?.fetchedAt ?? .distantPast)
    }
}

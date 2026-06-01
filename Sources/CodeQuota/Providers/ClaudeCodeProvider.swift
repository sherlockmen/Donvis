import AppKit
import Foundation

final class ClaudeCodeProvider: CLIUsageProvider, UsageProvider {
    let providerType = ProviderType.claudeCode
    private let bridge: ClaudeStatusLineInstalling & ClaudeStatusLineReading

    init(
        runner: ShellRunning = ShellCommandRunner(),
        parser: UsageTextParser = .init(),
        bridge: ClaudeStatusLineInstalling & ClaudeStatusLineReading = ClaudeStatusLineBridge()
    ) {
        self.bridge = bridge
        super.init(runner: runner, parser: parser)
    }

    func checkInstallation() async -> Bool { runner.locate("claude") != nil }

    func checkLoginStatus() async -> Bool {
        guard await checkInstallation(),
              let result = try? await runner.run(executable: "claude", arguments: ["auth", "status"], timeout: 10) else { return false }
        return result.exitCode == 0
    }

    func fetchUsage() async throws -> UsageSnapshot {
        let installed = await checkInstallation()
        try bridge.installIfNeeded()
        guard let limits = try bridge.readRateLimits() else {
            return .unknown(provider: .claudeCode, installed: installed, loggedIn: true, active: true, warning: "已接入 Claude，等待 Code 会话返回用量数据。")
        }
        let remaining = [limits.primary?.remainingPercent, limits.secondary?.remainingPercent].compactMap { $0 }.min()
        return UsageSnapshot(
            provider: .claudeCode, accountLabel: nil, planName: nil,
            remainingPercent: remaining, usedPercent: remaining.map { 100 - $0 },
            sessionRemainingPercent: limits.primary?.remainingPercent,
            weeklyRemainingPercent: limits.secondary?.remainingPercent,
            resetAt: limits.primary?.resetDate, weeklyResetAt: limits.secondary?.resetDate,
            isInstalled: installed, isLoggedIn: true, isActiveClient: true,
            source: .localStatusLine, fetchedAt: bridge.lastUpdatedAt ?? Date(),
            warningMessage: remaining == nil ? "Claude Code 尚未返回订阅额度。" : nil
        )
    }

    func parseUsageText(_ text: String) throws -> UsageSnapshot {
        try makeManualSnapshot(provider: .claudeCode, text: text)
    }

    func openUsagePage() {
        NSWorkspace.shared.open(URL(string: "https://console.anthropic.com/settings/usage")!)
    }

    var isBridgeInstalled: Bool { bridge.isInstalled }
}

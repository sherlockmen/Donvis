import Foundation

struct ClientActivity: Equatable {
    let activeProviders: Set<ProviderType>
    let mostRecentlyDetected: ProviderType?
    let activityDates: [ProviderType: Date]
}

final class ClientActivityDetector {
    private let runner: ShellRunning
    private(set) var mostRecentlyDetected: ProviderType?

    init(runner: ShellRunning = ShellCommandRunner()) {
        self.runner = runner
    }

    func detect() async -> ClientActivity {
        var dates: [ProviderType: Date] = [:]
        let codexDesktop = await processDate(matching: "^/Applications/Codex\\.app/Contents/MacOS/Codex$")
        let codexCLI = await processDate(matching: "(^|/)codex( |$)", excluding: [" app-server"])
        let claudeDesktop = await processDate(matching: "^/Applications/Claude\\.app/Contents/MacOS/Claude$")
        let claudeCLI = await processDate(matching: "(^|/)claude( |$)")
        if let date = [codexDesktop, codexCLI].compactMap({ $0 }).max() { dates[.codex] = date }
        if let date = [claudeDesktop, claudeCLI].compactMap({ $0 }).max() { dates[.claudeCode] = date }
        let active = Set(dates.keys)
        let recent = dates.max(by: { $0.value < $1.value })?.key
        if let recent { mostRecentlyDetected = recent }
        return ClientActivity(activeProviders: active, mostRecentlyDetected: mostRecentlyDetected, activityDates: dates)
    }

    static func selectProvider(
        mode: DisplayMode,
        snapshots: [ProviderType: UsageSnapshot],
        activity: ClientActivity,
        rotationIndex: Int = 0
    ) -> ProviderType {
        switch mode {
        case .codex: return .codex
        case .claudeCode: return .claudeCode
        case .rotate: return ProviderType.allCases[rotationIndex % ProviderType.allCases.count]
        case .auto:
            let active = activity.activeProviders
            if active.count == 1 { return active.first! }
            if active.count > 1 {
                if let recent = activity.mostRecentlyDetected { return recent }
            }
            return snapshots[.codex]?.remainingPercent != nil ? .codex : .claudeCode
        }
    }

    private func processDate(matching pattern: String, excluding fragments: [String] = []) async -> Date? {
        guard let result = try? await runner.run(executable: "pgrep", arguments: ["-fl", pattern], timeout: 5),
              result.exitCode == 0 else { return nil }
        var dates = [Date]()
        for line in result.stdout.split(separator: "\n").map(String.init) {
            guard !fragments.contains(where: line.contains),
                  let pid = line.split(separator: " ").first else { continue }
            let started = try? await runner.run(executable: "ps", arguments: ["-p", String(pid), "-o", "lstart="], timeout: 5)
            let text = started?.stdout.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            dates.append(Self.processDateFormatter.date(from: text) ?? Date())
        }
        return dates.max()
    }

    private static let processDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE MMM d HH:mm:ss yyyy"
        return formatter
    }()
}

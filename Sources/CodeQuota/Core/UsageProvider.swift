import Foundation

protocol UsageProvider {
    var providerType: ProviderType { get }
    func checkInstallation() async -> Bool
    func checkLoginStatus() async -> Bool
    func fetchUsage() async throws -> UsageSnapshot
    func parseUsageText(_ text: String) throws -> UsageSnapshot
}

enum ProviderError: LocalizedError {
    case cliNotInstalled(String)
    case notLoggedIn(String)

    var errorDescription: String? {
        switch self {
        case .cliNotInstalled(let name): return "\(name) CLI 未安装。"
        case .notLoggedIn(let name): return "\(name) 尚未登录。"
        }
    }
}

class CLIUsageProvider {
    let runner: ShellRunning
    let parser: UsageTextParser

    init(runner: ShellRunning = ShellCommandRunner(), parser: UsageTextParser = .init()) {
        self.runner = runner
        self.parser = parser
    }

    func makeManualSnapshot(provider: ProviderType, text: String) throws -> UsageSnapshot {
        let parsed = try parser.parse(text)
        return UsageSnapshot(
            provider: provider, accountLabel: nil, planName: nil,
            remainingPercent: parsed.remainingPercent, usedPercent: parsed.usedPercent,
            sessionRemainingPercent: nil, weeklyRemainingPercent: nil,
            resetAt: Self.parseDate(parsed.resetAtText), weeklyResetAt: nil,
            isInstalled: runner.locate(provider == .codex ? "codex" : "claude") != nil,
            isLoggedIn: true, isActiveClient: false, source: .manual,
            fetchedAt: Date(), warningMessage: parsed.warningMessage
        )
    }

    private static func parseDate(_ text: String?) -> Date? {
        guard let text else { return nil }
        for formatter in [ISO8601DateFormatter()] {
            if let date = formatter.date(from: text) { return date }
        }
        return nil
    }
}

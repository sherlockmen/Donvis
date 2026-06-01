import AppKit
import Foundation

final class CodexProvider: CLIUsageProvider, UsageProvider {
    let providerType = ProviderType.codex
    private let rateLimits: CodexRateLimitReading

    init(
        runner: ShellRunning = ShellCommandRunner(),
        parser: UsageTextParser = .init(),
        rateLimits: CodexRateLimitReading = CodexAppServerClient()
    ) {
        self.rateLimits = rateLimits
        super.init(runner: runner, parser: parser)
    }

    func checkInstallation() async -> Bool { runner.locate("codex") != nil }

    func checkLoginStatus() async -> Bool {
        guard await checkInstallation(),
              let result = try? await runner.run(executable: "codex", arguments: ["login", "status"], timeout: 10) else { return false }
        return result.exitCode == 0
    }

    func fetchUsage() async throws -> UsageSnapshot {
        let installed = await checkInstallation()
        guard installed else { return .unknown(provider: .codex, warning: "Codex CLI 未安装。") }
        do {
            let response = try await rateLimits.readUsage()
            if let limits = response.rateLimits {
                return Self.snapshot(from: limits, account: response.account)
            }
            if response.account?.type != nil {
                return .unknown(provider: .codex, installed: true, loggedIn: true, active: true, warning: "Codex 已连接，等待额度更新。")
            }
        } catch {
            let loggedIn = await checkLoginStatus()
            guard loggedIn else {
                return .unknown(provider: .codex, installed: true, active: true, warning: "Codex 需要登录，请在 Codex Desktop 或 CLI 中完成登录。")
            }
            return .unknown(provider: .codex, installed: true, loggedIn: true, active: true, warning: "Codex 已登录，但暂时无法读取额度。\(error.localizedDescription)")
        }
        return .unknown(provider: .codex, installed: true, active: true, warning: "Codex 需要登录，请在 Codex Desktop 或 CLI 中完成登录。")
    }

    func parseUsageText(_ text: String) throws -> UsageSnapshot {
        try makeManualSnapshot(provider: .codex, text: text)
    }

    func openDashboard() {
        NSWorkspace.shared.open(URL(string: "https://chatgpt.com/codex")!)
    }

    private static func snapshot(from limits: ProviderRateLimitSnapshot, account: CodexAccountSnapshot?) -> UsageSnapshot {
        let remaining = [limits.primary?.remainingPercent, limits.secondary?.remainingPercent].compactMap { $0 }.min()
        return UsageSnapshot(
            provider: .codex, accountLabel: account?.email, planName: limits.planType ?? account?.planType,
            remainingPercent: remaining, usedPercent: remaining.map { 100 - $0 },
            sessionRemainingPercent: limits.primary?.remainingPercent,
            weeklyRemainingPercent: limits.secondary?.remainingPercent,
            resetAt: limits.primary?.resetDate, weeklyResetAt: limits.secondary?.resetDate,
            isInstalled: true, isLoggedIn: true, isActiveClient: true,
            source: .officialCLI, fetchedAt: Date(), warningMessage: remaining == nil ? "Codex 暂未返回额度数据。" : nil
        )
    }
}

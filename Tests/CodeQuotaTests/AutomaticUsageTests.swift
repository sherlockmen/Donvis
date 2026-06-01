import XCTest
@testable import CodeQuota

final class AutomaticUsageTests: XCTestCase {
    func testCodexRPCUsageDoesNotDependOnLegacyLoginCommand() async throws {
        let limits = ProviderRateLimitSnapshot(
            primary: .init(usedPercent: 63, windowDurationMins: 300, resetsAt: nil),
            secondary: .init(usedPercent: 10, windowDurationMins: 10_080, resetsAt: nil),
            planType: "plus"
        )
        let provider = CodexProvider(
            runner: InstalledRunner(),
            rateLimits: FixedCodexReader(response: .init(
                account: .init(type: .chatgpt, email: "user@example.com", planType: "plus"),
                rateLimits: limits
            ))
        )
        let snapshot = try await provider.fetchUsage()
        XCTAssertTrue(snapshot.isLoggedIn)
        XCTAssertEqual(snapshot.connectionState, .connected)
        XCTAssertEqual(snapshot.sessionRemainingPercent, 37)
        XCTAssertEqual(snapshot.weeklyRemainingPercent, 90)
    }

    func testClaudeBridgeReadsOfficialRateLimits() throws {
        let home = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: home) }
        let support = home.appendingPathComponent("Library/Application Support/CodeQuota")
        try FileManager.default.createDirectory(at: support, withIntermediateDirectories: true)
        let json = """
        {"rate_limits":{"five_hour":{"used_percentage":23.5,"resets_at":1738425600},"seven_day":{"used_percentage":41.2,"resets_at":1738857600}}}
        """
        try Data(json.utf8).write(to: support.appendingPathComponent("claude-statusline.json"))
        let bridge = ClaudeStatusLineBridge(home: home)
        let limits = try XCTUnwrap(bridge.readRateLimits())
        XCTAssertEqual(limits.primary?.remainingPercent, 76.5)
        XCTAssertEqual(limits.secondary?.remainingPercent, 58.8)
    }

    func testClaudeBridgeInstallsIdempotentlyAndBacksUpSettings() throws {
        let home = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: home) }
        let claude = home.appendingPathComponent(".claude")
        try FileManager.default.createDirectory(at: claude, withIntermediateDirectories: true)
        try Data(#"{"statusLine":{"type":"command","command":"echo original"}}"#.utf8)
            .write(to: claude.appendingPathComponent("settings.json"))
        let bridge = ClaudeStatusLineBridge(home: home)
        try bridge.installIfNeeded()
        try bridge.installIfNeeded()
        XCTAssertTrue(bridge.isInstalled)
        XCTAssertTrue(FileManager.default.fileExists(atPath: claude.appendingPathComponent("settings.json.codequota-backup").path))
    }
}

private struct FixedCodexReader: CodexRateLimitReading {
    let response: CodexUsageResponse
    func readUsage() async throws -> CodexUsageResponse { response }
}

private struct InstalledRunner: ShellRunning {
    func locate(_ executable: String) -> String? { "/usr/bin/true" }
    func run(executable: String, arguments: [String], timeout: TimeInterval) async throws -> ShellCommandResult {
        .init(exitCode: 1, stdout: "", stderr: "legacy login check intentionally fails")
    }
}

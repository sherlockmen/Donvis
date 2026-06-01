import XCTest
@testable import CodeQuota

final class ShellCommandRunnerTests: XCTestCase {
    func testTimeout() async {
        let runner = ShellCommandRunner()
        do {
            _ = try await runner.run(executable: "/bin/sleep", arguments: ["2"], timeout: 0.01)
            XCTFail("Expected timeout")
        } catch ShellCommandError.timedOut {
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

import XCTest
@testable import CodeQuota

final class UsageTextParserTests: XCTestCase {
    private let parser = UsageTextParser()

    func testRemainingAfterKeyword() throws { XCTAssertEqual(try parser.parse("remaining 72%").remainingPercent, 72) }
    func testRemainingBeforeKeyword() throws { XCTAssertEqual(try parser.parse("72% remaining").remainingPercent, 72) }
    func testUsed() throws { XCTAssertEqual(try parser.parse("used 28%").remainingPercent, 72) }
    func testUsage() throws { XCTAssertEqual(try parser.parse("usage 28%").remainingPercent, 72) }
    func testRemainingWins() throws { XCTAssertEqual(try parser.parse("remaining 40%, used 80%").remainingPercent, 40) }
    func testClamp() throws { XCTAssertEqual(try parser.parse("used 140%").remainingPercent, 0) }
    func testResetText() throws { XCTAssertEqual(try parser.parse("remaining 12%\nreset in 2h").resetAtText, "2h") }
}

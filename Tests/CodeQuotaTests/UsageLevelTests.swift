import XCTest
@testable import CodeQuota

final class UsageLevelTests: XCTestCase {
    func testLevels() {
        XCTAssertEqual(UsageLevel(remainingPercent: nil), .unknown)
        XCTAssertEqual(UsageLevel(remainingPercent: 0), .exhausted)
        XCTAssertEqual(UsageLevel(remainingPercent: 9), .critical)
        XCTAssertEqual(UsageLevel(remainingPercent: 10), .warning)
        XCTAssertEqual(UsageLevel(remainingPercent: 60), .warning)
        XCTAssertEqual(UsageLevel(remainingPercent: 61), .normal)
    }
}

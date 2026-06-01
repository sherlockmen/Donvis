import XCTest
@testable import CodeQuota

final class ClientActivityDetectorTests: XCTestCase {
    func testFixedModes() {
        let activity = ClientActivity(activeProviders: [], mostRecentlyDetected: nil, activityDates: [:])
        XCTAssertEqual(ClientActivityDetector.selectProvider(mode: .codex, snapshots: [:], activity: activity), .codex)
        XCTAssertEqual(ClientActivityDetector.selectProvider(mode: .claudeCode, snapshots: [:], activity: activity), .claudeCode)
    }

    func testAutoSelectsLowerRemaining() {
        let snapshots: [ProviderType: UsageSnapshot] = [
            .codex: .fixture(.codex, remaining: 70),
            .claudeCode: .fixture(.claudeCode, remaining: 20)
        ]
        let activity = ClientActivity(activeProviders: [.codex, .claudeCode], mostRecentlyDetected: .codex, activityDates: [:])
        XCTAssertEqual(ClientActivityDetector.selectProvider(mode: .auto, snapshots: snapshots, activity: activity), .codex)
    }
}

extension UsageSnapshot {
    static func fixture(_ provider: ProviderType, remaining: Double?, fetchedAt: Date = Date()) -> UsageSnapshot {
        .init(provider: provider, accountLabel: nil, planName: nil, remainingPercent: remaining,
              usedPercent: remaining.map { 100 - $0 }, sessionRemainingPercent: nil, weeklyRemainingPercent: nil,
              resetAt: nil, weeklyResetAt: nil, isInstalled: true, isLoggedIn: true, isActiveClient: false,
              source: .manual, fetchedAt: fetchedAt, warningMessage: nil)
    }
}

import XCTest
@testable import CodeQuota

final class StorageTests: XCTestCase {
    func testCacheRoundTripAndStale() {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        let cache = UsageCacheStore(defaults: defaults)
        let old = UsageSnapshot.fixture(.codex, remaining: 40, fetchedAt: Date(timeIntervalSinceNow: -86_401))
        cache.save(old)
        XCTAssertEqual(cache.load(.codex), old)
        XCTAssertTrue(cache.isStale(old, now: Date()))
        cache.clear()
        XCTAssertNil(cache.load(.codex))
    }
}

final class MemoryCredentialStore: CredentialStoring {
    var values: [String: String] = [:]
    func save(_ value: String, account: String) throws { values[account] = value }
    func read(account: String) throws -> String? { values[account] }
    func delete(account: String) throws { values.removeValue(forKey: account) }
}

final class CredentialStoreTests: XCTestCase {
    func testMockRoundTrip() throws {
        let store = MemoryCredentialStore()
        try store.save("secret", account: "claude")
        XCTAssertEqual(try store.read(account: "claude"), "secret")
        try store.delete(account: "claude")
        XCTAssertNil(try store.read(account: "claude"))
    }
}

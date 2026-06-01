import XCTest
@testable import CodeQuota

final class AppSettingsTests: XCTestCase {
    func testSettingsPersist() {
        let name = UUID().uuidString
        let defaults = UserDefaults(suiteName: name)!
        let settings = AppSettings(defaults: defaults)
        settings.notificationsEnabled = false

        let restored = AppSettings(defaults: defaults)
        XCTAssertFalse(restored.notificationsEnabled)
        defaults.removePersistentDomain(forName: name)
    }
}

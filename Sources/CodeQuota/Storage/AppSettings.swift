import Foundation

final class AppSettings: ObservableObject {
    private enum Key {
        static let notificationsEnabled = "notificationsEnabled"
    }

    private let defaults: UserDefaults
    @Published var notificationsEnabled: Bool {
        didSet { defaults.set(notificationsEnabled, forKey: Key.notificationsEnabled) }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        notificationsEnabled = defaults.object(forKey: Key.notificationsEnabled) as? Bool ?? true
    }
}

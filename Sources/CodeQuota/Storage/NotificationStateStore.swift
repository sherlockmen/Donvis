import Foundation

final class NotificationStateStore {
    private let defaults: UserDefaults
    init(defaults: UserDefaults = .standard) { self.defaults = defaults }

    func shouldNotify(provider: ProviderType, threshold: String, resetAt: Date?) -> Bool {
        let window = resetAt.map { String(Int($0.timeIntervalSince1970)) } ?? "unknown"
        let key = "notification.\(provider.rawValue).\(window).\(threshold)"
        guard !defaults.bool(forKey: key) else { return false }
        defaults.set(true, forKey: key)
        return true
    }

    func markLow(provider: ProviderType, resetAt: Date?) {
        defaults.set(true, forKey: lowKey(provider: provider, resetAt: resetAt))
    }

    func shouldNotifyRecovery(provider: ProviderType, resetAt: Date?) -> Bool {
        guard defaults.bool(forKey: lowKey(provider: provider, resetAt: resetAt)) else { return false }
        return shouldNotify(provider: provider, threshold: "recovered", resetAt: resetAt)
    }

    private func lowKey(provider: ProviderType, resetAt: Date?) -> String {
        let window = resetAt.map { String(Int($0.timeIntervalSince1970)) } ?? "unknown"
        return "notification.\(provider.rawValue).\(window).wasLow"
    }
}

import Foundation
import UserNotifications

final class NotificationService {
    private let center: UNUserNotificationCenter
    private let state: NotificationStateStore

    init(center: UNUserNotificationCenter = .current(), state: NotificationStateStore = .init()) {
        self.center = center
        self.state = state
    }

    func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    func evaluate(_ snapshot: UsageSnapshot) {
        guard let remaining = snapshot.remainingPercent else { return }
        let threshold: String?
        let title: String
        if remaining <= 0 { threshold = "exhausted"; title = "\(snapshot.provider.displayName) 额度已耗尽" }
        else if remaining < 15 { threshold = "critical"; title = "\(snapshot.provider.displayName) 额度严重不足" }
        else if remaining < 30 { threshold = "low"; title = "\(snapshot.provider.displayName) 额度偏低" }
        else if remaining >= 50 { threshold = "recovered"; title = "\(snapshot.provider.displayName) 额度已恢复" }
        else { threshold = nil; title = "" }
        guard let threshold else { return }
        if remaining < 30 { state.markLow(provider: snapshot.provider, resetAt: snapshot.resetAt) }
        let shouldSend = threshold == "recovered"
            ? state.shouldNotifyRecovery(provider: snapshot.provider, resetAt: snapshot.resetAt)
            : state.shouldNotify(provider: snapshot.provider, threshold: threshold, resetAt: snapshot.resetAt)
        guard shouldSend else { return }
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "当前剩余额度约为 \(Int(remaining.rounded()))%。"
        center.add(.init(identifier: "\(snapshot.provider.rawValue).\(threshold)", content: content, trigger: nil))
    }
}

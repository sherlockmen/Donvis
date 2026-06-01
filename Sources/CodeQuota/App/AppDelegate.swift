import AppKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private var monitor: UsageMonitorService?
    private var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.setActivationPolicy(.accessory)
        let iconURL = Bundle.main.url(forResource: "AppIcon", withExtension: "icns")
        if let icon = iconURL.flatMap(NSImage.init(contentsOf:)) {
            NSApplication.shared.applicationIconImage = icon
        }
        let monitor = UsageMonitorService()
        self.monitor = monitor
        statusBar = StatusBarController(monitor: monitor)
        monitor.start()
    }

    func applicationWillTerminate(_ notification: Notification) {
        monitor?.stop()
    }
}

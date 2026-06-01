import AppKit
import Combine
import SwiftUI

@MainActor
final class StatusBarController: NSObject, NSPopoverDelegate {
    private let monitor: UsageMonitorService
    private let statusItem = NSStatusBar.system.statusItem(withLength: 128)
    private let popover = NSPopover()
    private var statusHostingView: NSHostingView<StatusItemView>?
    private var localMouseMonitor: Any?
    private var globalMouseMonitor: Any?
    private var cancellables = Set<AnyCancellable>()
    private var didPresentInitialStatus = false

    init(monitor: UsageMonitorService) {
        self.monitor = monitor
        super.init()
        popover.behavior = .transient
        popover.delegate = self
        popover.contentSize = NSSize(width: 390, height: 440)
        configureStatusButton()
        monitor.objectWillChange.receive(on: RunLoop.main).sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.update()
                self?.presentInitialStatusIfNeeded()
            }
        }.store(in: &cancellables)
        update()
    }

    func update() {
        let view = StatusItemView(provider: monitor.activeProvider, snapshot: monitor.activeSnapshot)
        if let statusHostingView {
            statusHostingView.rootView = view
        } else if let button = statusItem.button {
            let hostingView = NSHostingView(rootView: view)
            hostingView.frame = button.bounds
            hostingView.autoresizingMask = [.width, .height]
            button.addSubview(hostingView)
            statusHostingView = hostingView
        }
    }

    @objc private func togglePopover() {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            showPopoverWhenAnchored()
        }
    }

    private func configureStatusButton() {
        guard let button = statusItem.button else { return }
        button.action = #selector(togglePopover)
        button.target = self
        button.title = ""
        button.image = nil
    }

    private func presentInitialStatusIfNeeded() {
        guard monitor.hasCompletedInitialCheck, !didPresentInitialStatus else { return }
        didPresentInitialStatus = true
        DispatchQueue.main.async { [weak self] in self?.showPopoverWhenAnchored() }
    }

    private func showPopoverWhenAnchored(attempt: Int = 0) {
        guard let button = statusItem.button,
              let window = button.window,
              window.screen != nil,
              !button.bounds.isEmpty,
              window.convertToScreen(button.convert(button.bounds, to: nil)).midX > 0 else {
            guard attempt < 6 else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.showPopoverWhenAnchored(attempt: attempt + 1)
            }
            return
        }
        popover.contentViewController = NSHostingController(rootView: PopoverView(monitor: monitor))
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        installMouseMonitors()
    }

    private func installMouseMonitors() {
        removeMouseMonitors()
        localMouseMonitor = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self else { return event }
            if self.isOutsidePopover(at: NSEvent.mouseLocation) { self.popover.performClose(nil) }
            return event
        }
        globalMouseMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] _ in
            guard let self else { return }
            if self.isOutsidePopover(at: NSEvent.mouseLocation) { self.popover.performClose(nil) }
        }
    }

    private func removeMouseMonitors() {
        if let localMouseMonitor { NSEvent.removeMonitor(localMouseMonitor) }
        if let globalMouseMonitor { NSEvent.removeMonitor(globalMouseMonitor) }
        localMouseMonitor = nil
        globalMouseMonitor = nil
    }

    private func isOutsidePopover(at point: NSPoint) -> Bool {
        let popoverFrame = popover.contentViewController?.view.window?.frame ?? .zero
        let buttonFrame = statusItem.button.flatMap { button in
            button.window?.convertToScreen(button.convert(button.bounds, to: nil))
        } ?? .zero
        return !popoverFrame.contains(point) && !buttonFrame.contains(point)
    }

    func popoverDidClose(_ notification: Notification) {
        removeMouseMonitors()
    }
}

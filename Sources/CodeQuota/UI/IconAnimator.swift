import AppKit

final class IconAnimator {
    private var timer: Timer?
    private var index = 0

    func start(on button: NSStatusBarButton, frames: [NSImage], interval: TimeInterval = 0.8) {
        stop()
        guard !frames.isEmpty else { return }
        button.image = frames[0]
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self, weak button] _ in
            guard let self, let button else { return }
            self.index = (self.index + 1) % frames.count
            button.image = frames[self.index]
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        index = 0
    }

    static func frames(for provider: ProviderType) -> [NSImage] {
        let names = provider == .codex
            ? ["chevron.left.forwardslash.chevron.right", "curlybraces", "terminal"]
            : ["sparkles", "command", "terminal"]
        return names.compactMap {
            let image = NSImage(systemSymbolName: $0, accessibilityDescription: provider.displayName)
            image?.isTemplate = true
            return image
        }
    }

    static func staticIcon(for provider: ProviderType?) -> NSImage? {
        let name: String
        let description: String
        switch provider {
        case .codex:
            name = "chevron.left.forwardslash.chevron.right"
            description = "Codex"
        case .claudeCode:
            name = "sparkles"
            description = "Claude Code"
        case nil:
            name = "bolt.horizontal.circle"
            description = "未接入"
        }
        let image = NSImage(systemSymbolName: name, accessibilityDescription: description)
        image?.isTemplate = true
        return image
    }
}

import AppKit
import SwiftUI

enum ProviderIcon {
    static func image(for provider: ProviderType?) -> NSImage? {
        guard let provider else {
            let image = NSImage(systemSymbolName: "bolt.horizontal.circle", accessibilityDescription: "未接入")
            image?.isTemplate = true
            return image
        }
        let name = provider == .codex ? "openai" : "claude"
        guard let url = resourceBundle.url(forResource: name, withExtension: "svg", subdirectory: "MenuBarIcons"),
              let image = NSImage(contentsOf: url) else { return nil }
        image.isTemplate = true
        image.accessibilityDescription = provider.displayName
        return image
    }

    private static var resourceBundle: Bundle {
        let appBundle = Bundle.main.bundleURL
            .appendingPathComponent("Contents/Resources/CodeQuota_CodeQuota.bundle")
        return Bundle(url: appBundle) ?? Bundle.module
    }
}

struct ProviderIconView: View {
    let provider: ProviderType?
    var size: CGFloat = 18

    var body: some View {
        if let image = ProviderIcon.image(for: provider) {
            Image(nsImage: image)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: size, height: size)
        }
    }
}

struct QuotaProgressBar: View {
    let title: String
    let remainingPercent: Double?
    var compact = false

    var body: some View {
        HStack(spacing: compact ? 4 : 8) {
            Text(title)
                .font(compact ? .system(size: 8, weight: .medium) : .caption.weight(.medium))
                .foregroundStyle(.secondary)
                .frame(width: compact ? 14 : 30, alignment: .leading)
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule().fill(.secondary.opacity(0.18))
                    Capsule()
                        .fill(levelColor)
                        .frame(width: proxy.size.width * fraction)
                }
            }
            .frame(height: compact ? 3 : 8)
            Text(percentText)
                .font(compact ? .system(size: 8, weight: .semibold, design: .rounded) : .caption.monospacedDigit().weight(.semibold))
                .foregroundStyle(levelColor)
                .frame(width: compact ? 24 : 36, alignment: .trailing)
        }
    }

    private var fraction: CGFloat {
        CGFloat(min(100, max(0, remainingPercent ?? 0)) / 100)
    }

    private var percentText: String {
        remainingPercent.map { "\(Int($0.rounded()))%" } ?? "?"
    }

    private var levelColor: Color {
        switch UsageLevel(remainingPercent: remainingPercent) {
        case .normal: return .green
        case .warning: return .orange
        case .critical, .exhausted: return .red
        case .unknown: return .secondary
        }
    }
}

struct StatusItemView: View {
    let provider: ProviderType?
    let snapshot: UsageSnapshot?

    var body: some View {
        HStack(spacing: 6) {
            ProviderIconView(provider: provider, size: 16)
            if let provider {
                if snapshot?.connectionState == .connected {
                    VStack(spacing: 2) {
                        QuotaProgressBar(title: "5h", remainingPercent: snapshot?.sessionRemainingPercent, compact: true)
                        QuotaProgressBar(title: "7d", remainingPercent: snapshot?.weeklyRemainingPercent, compact: true)
                    }
                } else {
                    Text(snapshot?.connectionState.displayName ?? provider.shortName)
                        .font(.system(size: 10, weight: .medium))
                }
            } else {
                Text("未接入").font(.system(size: 10, weight: .medium))
            }
        }
        .padding(.horizontal, 4)
        .frame(width: 128, height: 22)
        .contentShape(Rectangle())
        .allowsHitTesting(false)
    }
}

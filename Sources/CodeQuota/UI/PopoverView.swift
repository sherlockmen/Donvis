import AppKit
import SwiftUI

struct PopoverView: View {
    @ObservedObject var monitor: UsageMonitorService
    @State private var page = Page.overview

    enum Page { case overview, settings }

    var body: some View {
        ZStack {
            Rectangle().fill(.ultraThinMaterial)
            Group {
                switch page {
                case .overview: overview
                case .settings: SettingsView(monitor: monitor) { page = .overview }
                }
            }
            .padding(14)
        }
        .frame(width: 390, height: 440)
    }

    private var overview: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("CodeQuota").font(.title3.weight(.semibold))
                Spacer()
                Text(monitor.activeProvider.map { "当前：\($0.displayName)" } ?? "当前：未接入")
                    .font(.caption).foregroundStyle(.secondary)
            }
            if let provider = monitor.activeProvider {
                ProviderCardView(provider: provider, snapshot: monitor.snapshots[provider], stale: monitor.isStale(provider))
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        ProviderIconView(provider: nil, size: 22)
                        Text("未接入").font(.headline)
                    }
                    Text("当前没有检测到 Codex 或 Claude 正在活动。启动客户端后，额度会自动出现。")
                        .font(.callout).foregroundStyle(.secondary)
                }
                .padding(14)
                .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 14))
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(.white.opacity(0.16)))
            }
            if let message = monitor.errorMessage {
                Text(message).font(.caption).foregroundStyle(.red)
            }
            Spacer()
            HStack {
                Button {
                    Task { await monitor.refresh() }
                } label: {
                    Label("立即刷新", systemImage: "arrow.clockwise")
                }
                .disabled(monitor.isRefreshing)
                Spacer()
                Button { page = .settings } label: { Image(systemName: "gearshape") }
                Button("退出") { NSApplication.shared.terminate(nil) }
            }
            .buttonStyle(.bordered)
        }
    }
}

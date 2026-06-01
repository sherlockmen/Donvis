import SwiftUI

struct SettingsView: View {
    @ObservedObject var monitor: UsageMonitorService
    @ObservedObject private var settings: AppSettings
    @State private var launchAtLogin = false
    let onBack: () -> Void

    init(monitor: UsageMonitorService, onBack: @escaping () -> Void) {
        self.monitor = monitor
        self.onBack = onBack
        settings = monitor.settings
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack {
                Button(action: onBack) { Image(systemName: "chevron.left") }
                    .buttonStyle(.borderless)
                Text("设置").font(.title3.weight(.semibold))
                Spacer()
                Text("CodeQuota 0.3.0").font(.caption).foregroundStyle(.secondary)
            }

            settingsCard("通用") {
                Toggle("登录时启动", isOn: $launchAtLogin)
                    .onChange(of: launchAtLogin) { monitor.setLaunchAtLogin($0) }
                Toggle("本地额度通知", isOn: $settings.notificationsEnabled)
            }

            settingsCard("自动监控") {
                Text("每 5 秒检测活动客户端，每 60 秒自动刷新额度。无需粘贴数据或填写 API Key。")
                Divider()
                LabeledContent("Codex", value: "官方 app-server RPC")
                LabeledContent("Claude", value: monitor.claudeBridgeInstalled ? "statusLine 桥接已安装" : "运行后自动安装桥接")
            }

            settingsCard("隐私") {
                Text("数据仅保存在本机。Claude bridge 会备份并合并用户级 settings.json，不抓取 Cookie，也不上传数据。")
                if let error = monitor.launchAtLoginError {
                    Text(error).foregroundStyle(.orange)
                }
            }
            Spacer()
        }
        .font(.callout)
        .onAppear { launchAtLogin = monitor.launchAtLoginEnabled }
    }

    private func settingsCard<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.caption.weight(.semibold)).foregroundStyle(.secondary)
            content()
        }
        .padding(11)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white.opacity(0.14)))
    }
}

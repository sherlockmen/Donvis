import SwiftUI

struct ProviderCardView: View {
    let provider: ProviderType
    let snapshot: UsageSnapshot?
    let stale: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 9) {
                ProviderIconView(provider: provider, size: 22)
                VStack(alignment: .leading, spacing: 1) {
                    Text(provider.displayName).font(.headline)
                    Text(snapshot?.connectionState.displayName ?? "正在连接")
                        .font(.caption)
                        .foregroundStyle(statusColor)
                }
                Spacer()
                if let planName = snapshot?.planName {
                    Text(planName.uppercased())
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(.secondary)
                }
            }

            VStack(spacing: 13) {
                quotaRow(title: "5 小时", value: snapshot?.sessionRemainingPercent, resetAt: snapshot?.resetAt)
                quotaRow(title: "7 天", value: snapshot?.weeklyRemainingPercent, resetAt: snapshot?.weeklyResetAt)
            }

            VStack(alignment: .leading, spacing: 4) {
                if let fetchedAt = snapshot?.fetchedAt {
                    Text("更新于 \(fetchedAt.formatted(date: .abbreviated, time: .shortened))")
                }
                if stale { Text("数据已过期，正在等待自动刷新。").foregroundStyle(.orange) }
                if let warning = snapshot?.warningMessage { Text(warning) }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(14)
        .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(.white.opacity(0.16)))
    }

    private func quotaRow(title: String, value: Double?, resetAt: Date?) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            QuotaProgressBar(title: title, remainingPercent: value)
            Text(resetAt.map { "重置：\($0.formatted(date: .abbreviated, time: .shortened))" } ?? "重置时间：等待更新")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .padding(.leading, 38)
        }
    }

    private var statusColor: Color {
        switch snapshot?.connectionState {
        case .connected: return .green
        case .authenticationRequired: return .red
        case .waitingForUsage, .connecting: return .orange
        default: return .secondary
        }
    }
}

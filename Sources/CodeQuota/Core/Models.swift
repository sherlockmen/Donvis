import Foundation

enum ProviderType: String, Codable, CaseIterable, Identifiable {
    case codex
    case claudeCode

    var id: String { rawValue }
    var displayName: String { self == .codex ? "Codex" : "Claude Code" }
    var shortName: String { self == .codex ? "Codex" : "Claude" }
}

enum UsageSource: String, Codable {
    case officialCLI, officialDashboard, localStatusLine, localConfig, manual, apiHeader, unknown
}

enum ProviderConnectionState: String, Codable, Equatable {
    case disconnected
    case connecting
    case connected
    case waitingForUsage
    case authenticationRequired
    case unavailable

    var displayName: String {
        switch self {
        case .disconnected: return "未接入"
        case .connecting: return "正在连接"
        case .connected: return "已连接"
        case .waitingForUsage: return "等待用量更新"
        case .authenticationRequired: return "需要登录"
        case .unavailable: return "暂不可用"
        }
    }
}

struct UsageSnapshot: Codable, Equatable {
    let provider: ProviderType
    let accountLabel: String?
    let planName: String?
    let remainingPercent: Double?
    let usedPercent: Double?
    let sessionRemainingPercent: Double?
    let weeklyRemainingPercent: Double?
    let resetAt: Date?
    let weeklyResetAt: Date?
    let isInstalled: Bool
    let isLoggedIn: Bool
    let isActiveClient: Bool
    let source: UsageSource
    let fetchedAt: Date
    let warningMessage: String?

    static func unknown(
        provider: ProviderType,
        installed: Bool = false,
        loggedIn: Bool = false,
        active: Bool = false,
        connectionState: ProviderConnectionState? = nil,
        warning: String? = nil,
        fetchedAt: Date = Date()
    ) -> UsageSnapshot {
        UsageSnapshot(
            provider: provider, accountLabel: nil, planName: nil,
            remainingPercent: nil, usedPercent: nil, sessionRemainingPercent: nil,
            weeklyRemainingPercent: nil, resetAt: nil, weeklyResetAt: nil,
            isInstalled: installed, isLoggedIn: loggedIn, isActiveClient: active,
            source: .unknown, fetchedAt: fetchedAt, warningMessage: warning
        )
    }

    var level: UsageLevel { UsageLevel(remainingPercent: remainingPercent) }
    var connectionState: ProviderConnectionState {
        if source != .unknown || remainingPercent != nil { return .connected }
        if warningMessage?.contains("等待") == true { return .waitingForUsage }
        if isInstalled, !isLoggedIn { return .authenticationRequired }
        if isActiveClient { return .connecting }
        return .disconnected
    }
}

enum UsageLevel: String {
    case normal, warning, critical, exhausted, unknown

    init(remainingPercent: Double?) {
        guard let remainingPercent else { self = .unknown; return }
        switch remainingPercent {
        case ...0: self = .exhausted
        case ..<10: self = .critical
        case ...60: self = .warning
        default: self = .normal
        }
    }

    var trafficLight: String {
        switch self {
        case .normal: return "🟢"
        case .warning: return "🟡"
        case .critical, .exhausted: return "🔴"
        case .unknown: return ""
        }
    }
}

enum DisplayMode: String, Codable, CaseIterable, Identifiable {
    case auto, codex, claudeCode, rotate

    var id: String { rawValue }
    var displayName: String {
        switch self {
        case .auto: return "自动"
        case .codex: return "固定 Codex"
        case .claudeCode: return "固定 Claude Code"
        case .rotate: return "轮播"
        }
    }
}

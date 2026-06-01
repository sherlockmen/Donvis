import Foundation

protocol UsageCacheStoring {
    func save(_ snapshot: UsageSnapshot)
    func load(_ provider: ProviderType) -> UsageSnapshot?
    func clear()
    func isStale(_ snapshot: UsageSnapshot, now: Date) -> Bool
}

final class UsageCacheStore: UsageCacheStoring {
    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(defaults: UserDefaults = .standard) { self.defaults = defaults }

    func save(_ snapshot: UsageSnapshot) {
        defaults.set(try? encoder.encode(snapshot), forKey: key(snapshot.provider))
    }

    func load(_ provider: ProviderType) -> UsageSnapshot? {
        defaults.data(forKey: key(provider)).flatMap { try? decoder.decode(UsageSnapshot.self, from: $0) }
    }

    func clear() { ProviderType.allCases.forEach { defaults.removeObject(forKey: key($0)) } }
    func isStale(_ snapshot: UsageSnapshot, now: Date = Date()) -> Bool { now.timeIntervalSince(snapshot.fetchedAt) > 24 * 60 * 60 }
    private func key(_ provider: ProviderType) -> String { "usageSnapshot.\(provider.rawValue)" }
}

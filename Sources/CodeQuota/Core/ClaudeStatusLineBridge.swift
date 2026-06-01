import Foundation

protocol ClaudeStatusLineInstalling {
    func installIfNeeded() throws
    var isInstalled: Bool { get }
}

protocol ClaudeStatusLineReading {
    func readRateLimits() throws -> ProviderRateLimitSnapshot?
    var lastUpdatedAt: Date? { get }
}

enum ClaudeBridgeError: LocalizedError {
    case invalidSettings

    var errorDescription: String? { "Claude Code 用户设置不是有效的 JSON，无法自动安装用量桥接。" }
}

final class ClaudeStatusLineBridge: ClaudeStatusLineInstalling, ClaudeStatusLineReading {
    private let fileManager: FileManager
    private let home: URL
    private let supportDirectory: URL

    init(fileManager: FileManager = .default, home: URL = FileManager.default.homeDirectoryForCurrentUser) {
        self.fileManager = fileManager
        self.home = home
        supportDirectory = home.appendingPathComponent("Library/Application Support/CodeQuota", isDirectory: true)
    }

    var isInstalled: Bool {
        guard let settings = readSettings(),
              let statusLine = settings["statusLine"] as? [String: Any] else { return false }
        return statusLine["command"] as? String == bridgeScript.path
    }

    var lastUpdatedAt: Date? {
        (try? usageFile.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate
    }

    func installIfNeeded() throws {
        try fileManager.createDirectory(at: supportDirectory, withIntermediateDirectories: true)
        try writeBridgeScript()

        let settingsURL = claudeDirectory.appendingPathComponent("settings.json")
        try fileManager.createDirectory(at: claudeDirectory, withIntermediateDirectories: true)
        var settings = try readSettingsStrict()
        let existing = settings["statusLine"] as? [String: Any]
        if existing?["command"] as? String == bridgeScript.path { return }

        if fileManager.fileExists(atPath: settingsURL.path) {
            let backup = claudeDirectory.appendingPathComponent("settings.json.codequota-backup")
            if !fileManager.fileExists(atPath: backup.path) {
                try fileManager.copyItem(at: settingsURL, to: backup)
            }
        }

        if let command = existing?["command"] as? String, !command.isEmpty {
            try Data(command.utf8).write(to: originalCommandFile, options: .atomic)
        } else if fileManager.fileExists(atPath: originalCommandFile.path) {
            try fileManager.removeItem(at: originalCommandFile)
        }
        settings["statusLine"] = ["type": "command", "command": bridgeScript.path, "padding": existing?["padding"] ?? 0]
        let data = try JSONSerialization.data(withJSONObject: settings, options: [.prettyPrinted, .sortedKeys])
        try data.write(to: settingsURL, options: .atomic)
    }

    func readRateLimits() throws -> ProviderRateLimitSnapshot? {
        guard fileManager.fileExists(atPath: usageFile.path) else { return nil }
        let data = try Data(contentsOf: usageFile)
        let input = try JSONDecoder().decode(ClaudeStatusLineInput.self, from: data)
        return ProviderRateLimitSnapshot(
            primary: input.rateLimits?.fiveHour.map(Self.window),
            secondary: input.rateLimits?.sevenDay.map(Self.window),
            planType: nil
        )
    }

    private func writeBridgeScript() throws {
        let script = """
        #!/bin/zsh
        set -eu
        SUPPORT_DIR="$HOME/Library/Application Support/CodeQuota"
        INPUT_FILE="$SUPPORT_DIR/claude-statusline.json"
        ORIGINAL_FILE="$SUPPORT_DIR/claude-original-statusline-command"
        mkdir -p "$SUPPORT_DIR"
        chmod 700 "$SUPPORT_DIR"
        TMP_FILE="$(mktemp "$SUPPORT_DIR/.claude-statusline.XXXXXX")"
        cat > "$TMP_FILE"
        chmod 600 "$TMP_FILE"
        mv "$TMP_FILE" "$INPUT_FILE"
        if [ -s "$ORIGINAL_FILE" ]; then
          /bin/zsh -lc "$(cat "$ORIGINAL_FILE")" < "$INPUT_FILE"
        fi
        """
        try Data(script.utf8).write(to: bridgeScript, options: .atomic)
        try fileManager.setAttributes([.posixPermissions: 0o700], ofItemAtPath: bridgeScript.path)
    }

    private func readSettings() -> [String: Any]? { try? readSettingsStrict() }

    private func readSettingsStrict() throws -> [String: Any] {
        let settingsURL = claudeDirectory.appendingPathComponent("settings.json")
        guard fileManager.fileExists(atPath: settingsURL.path) else { return [:] }
        let object = try JSONSerialization.jsonObject(with: Data(contentsOf: settingsURL))
        guard let dictionary = object as? [String: Any] else { throw ClaudeBridgeError.invalidSettings }
        return dictionary
    }

    private static func window(_ value: ClaudeWindow) -> RateLimitWindowSnapshot {
        .init(usedPercent: value.usedPercentage, windowDurationMins: nil, resetsAt: value.resetsAt)
    }

    private var claudeDirectory: URL { home.appendingPathComponent(".claude", isDirectory: true) }
    private var bridgeScript: URL { supportDirectory.appendingPathComponent("claude-statusline-bridge.zsh") }
    private var originalCommandFile: URL { supportDirectory.appendingPathComponent("claude-original-statusline-command") }
    private var usageFile: URL { supportDirectory.appendingPathComponent("claude-statusline.json") }
}

private struct ClaudeStatusLineInput: Decodable {
    let rateLimits: ClaudeRateLimits?
    enum CodingKeys: String, CodingKey { case rateLimits = "rate_limits" }
}

private struct ClaudeRateLimits: Decodable {
    let fiveHour: ClaudeWindow?
    let sevenDay: ClaudeWindow?
    enum CodingKeys: String, CodingKey { case fiveHour = "five_hour"; case sevenDay = "seven_day" }
}

private struct ClaudeWindow: Decodable {
    let usedPercentage: Double
    let resetsAt: Int?
    enum CodingKeys: String, CodingKey { case usedPercentage = "used_percentage"; case resetsAt = "resets_at" }
}

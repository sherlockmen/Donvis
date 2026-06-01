import Foundation

struct ParsedUsage: Equatable {
    let remainingPercent: Double?
    let usedPercent: Double?
    let resetAtText: String?
    let warningMessage: String?
}

enum UsageParseError: LocalizedError {
    case noUsageFound

    var errorDescription: String? { "未在粘贴内容中找到可识别的额度百分比。" }
}

struct UsageTextParser {
    func parse(_ text: String) throws -> ParsedUsage {
        let remaining = firstPercent(in: text, patterns: [
            #"\bremaining\s*[:=]?\s*(\d+(?:\.\d+)?)\s*%"#,
            #"(\d+(?:\.\d+)?)\s*%\s*remaining\b"#
        ])
        let used = firstPercent(in: text, patterns: [
            #"\bused\s*[:=]?\s*(\d+(?:\.\d+)?)\s*%"#,
            #"\busage\s*[:=]?\s*(\d+(?:\.\d+)?)\s*%"#,
            #"(\d+(?:\.\d+)?)\s*%\s*used\b"#
        ])
        guard remaining != nil || used != nil else { throw UsageParseError.noUsageFound }
        return ParsedUsage(
            remainingPercent: clamp(remaining ?? used.map { 100 - $0 }),
            usedPercent: clamp(used ?? remaining.map { 100 - $0 }),
            resetAtText: firstText(in: text, pattern: #"\b(?:reset(?:s)?(?:\s+at|\s+in)?|renews?\s+at|limit\s+resets?)\s*[:=]?\s*([^\n\r]+)"#),
            warningMessage: nil
        )
    }

    private func firstPercent(in text: String, patterns: [String]) -> Double? {
        for pattern in patterns {
            if let value = firstText(in: text, pattern: pattern).flatMap(Double.init) { return value }
        }
        return nil
    }

    private func firstText(in text: String, pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]),
              let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
              match.numberOfRanges > 1,
              let range = Range(match.range(at: 1), in: text) else { return nil }
        return String(text[range]).trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func clamp(_ value: Double?) -> Double? {
        value.map { min(100, max(0, $0)) }
    }
}

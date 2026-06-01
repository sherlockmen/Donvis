import Foundation

struct RateLimitWindowSnapshot: Codable, Equatable {
    let usedPercent: Double
    let windowDurationMins: Int?
    let resetsAt: Int?

    var remainingPercent: Double { min(100, max(0, 100 - usedPercent)) }
    var resetDate: Date? { resetsAt.map { Date(timeIntervalSince1970: TimeInterval($0)) } }
}

struct ProviderRateLimitSnapshot: Codable, Equatable {
    let primary: RateLimitWindowSnapshot?
    let secondary: RateLimitWindowSnapshot?
    let planType: String?
}

enum CodexAuthMode: String, Codable, Equatable {
    case chatgpt
    case apiKey
}

struct CodexAccountSnapshot: Codable, Equatable {
    let type: CodexAuthMode?
    let email: String?
    let planType: String?
}

struct CodexUsageResponse: Codable, Equatable {
    let account: CodexAccountSnapshot?
    let rateLimits: ProviderRateLimitSnapshot?
}

protocol CodexRateLimitReading {
    func readUsage() async throws -> CodexUsageResponse
}

enum CodexAppServerError: LocalizedError {
    case unavailable
    case invalidResponse
    case timedOut

    var errorDescription: String? {
        switch self {
        case .unavailable: return "无法启动 Codex app-server。"
        case .invalidResponse: return "Codex app-server 返回了无法识别的账户数据。"
        case .timedOut: return "读取 Codex 用量超时。"
        }
    }
}

final class CodexAppServerClient: CodexRateLimitReading {
    private let runner: ShellRunning

    init(runner: ShellRunning = ShellCommandRunner()) {
        self.runner = runner
    }

    func readUsage() async throws -> CodexUsageResponse {
        guard let executable = preferredExecutable else { throw CodexAppServerError.unavailable }
        return try await withCheckedThrowingContinuation { continuation in
            let process = Process()
            let input = Pipe()
            let output = Pipe()
            let gate = CodexRPCCompletionGate()

            process.executableURL = URL(fileURLWithPath: executable)
            process.arguments = ["app-server", "--listen", "stdio://"]
            process.standardInput = input
            process.standardOutput = output
            process.standardError = Pipe()

            output.fileHandleForReading.readabilityHandler = { handle in
                let data = handle.availableData
                guard !data.isEmpty else { return }
                gate.append(data)
                if let response = gate.extractResponse() {
                    output.fileHandleForReading.readabilityHandler = nil
                    if process.isRunning { process.terminate() }
                    gate.finish(.success(response), continuation: continuation)
                }
            }

            do {
                try process.run()
                let messages = [
                    #"{"method":"initialize","id":0,"params":{"clientInfo":{"name":"codequota","title":"CodeQuota","version":"0.3.0"}}}"#,
                    #"{"method":"initialized","params":{}}"#,
                    #"{"method":"account/read","id":6,"params":{"refreshToken":false}}"#,
                    #"{"method":"account/rateLimits/read","id":7}"#
                ].joined(separator: "\n") + "\n"
                input.fileHandleForWriting.write(Data(messages.utf8))
            } catch {
                gate.finish(.failure(error), continuation: continuation)
                return
            }

            DispatchQueue.global().asyncAfter(deadline: .now() + 8) {
                output.fileHandleForReading.readabilityHandler = nil
                if process.isRunning { process.terminate() }
                gate.finish(.failure(CodexAppServerError.timedOut), continuation: continuation)
            }
        }
    }

    private var preferredExecutable: String? {
        runner.locate("/Applications/Codex.app/Contents/Resources/codex") ?? runner.locate("codex")
    }
}

private final class CodexRPCCompletionGate: @unchecked Sendable {
    private let lock = NSLock()
    private var buffer = Data()
    private var completed = false

    func append(_ data: Data) {
        lock.lock()
        buffer.append(data)
        lock.unlock()
    }

    func extractResponse() -> CodexUsageResponse? {
        lock.lock()
        defer { lock.unlock() }
        var account: CodexAccountSnapshot?
        var limits: ProviderRateLimitSnapshot?
        var receivedAccountResponse = false
        var receivedLimitsResponse = false
        for line in String(decoding: buffer, as: UTF8.self).split(separator: "\n") {
            guard let data = line.data(using: .utf8),
                  let envelope = try? JSONDecoder().decode(CodexRPCEnvelope.self, from: data) else { continue }
            if envelope.id == 6 {
                receivedAccountResponse = true
                account = envelope.result?.account
            }
            if envelope.id == 7 {
                receivedLimitsResponse = true
                limits = envelope.result?.rateLimits
            }
        }
        guard receivedAccountResponse, receivedLimitsResponse else { return nil }
        return CodexUsageResponse(account: account, rateLimits: limits)
    }

    func finish(
        _ result: Result<CodexUsageResponse, Error>,
        continuation: CheckedContinuation<CodexUsageResponse, Error>
    ) {
        lock.lock()
        guard !completed else { lock.unlock(); return }
        completed = true
        lock.unlock()
        continuation.resume(with: result)
    }
}

private struct CodexRPCEnvelope: Decodable {
    let id: Int?
    let result: ResultPayload?

    struct ResultPayload: Decodable {
        let account: CodexAccountSnapshot?
        let rateLimits: ProviderRateLimitSnapshot?
    }
}

import Foundation

struct ShellCommandResult: Equatable {
    let exitCode: Int32
    let stdout: String
    let stderr: String
}

enum ShellCommandError: LocalizedError {
    case executableNotFound(String)
    case timedOut

    var errorDescription: String? {
        switch self {
        case .executableNotFound(let executable): return "找不到命令：\(executable)"
        case .timedOut: return "命令执行超时。"
        }
    }
}

private final class CompletionGate: @unchecked Sendable {
    private let lock = NSLock()
    private var completed = false

    func finish(_ result: Result<ShellCommandResult, Error>, continuation: CheckedContinuation<ShellCommandResult, Error>) {
        lock.lock()
        guard !completed else { lock.unlock(); return }
        completed = true
        lock.unlock()
        continuation.resume(with: result)
    }
}

protocol ShellRunning {
    func run(executable: String, arguments: [String], timeout: TimeInterval) async throws -> ShellCommandResult
    func locate(_ executable: String) -> String?
}

final class ShellCommandRunner: ShellRunning {
    private let searchPaths: [String]

    init(environment: [String: String] = ProcessInfo.processInfo.environment) {
        let path = environment["PATH"]?.split(separator: ":").map(String.init) ?? []
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let nvmRoot = "\(home)/.nvm/versions/node"
        let nvmPaths = (try? FileManager.default.contentsOfDirectory(atPath: nvmRoot))?
            .map { "\(nvmRoot)/\($0)/bin" } ?? []
        searchPaths = path + nvmPaths + [
            "/Applications/Codex.app/Contents/Resources",
            "\(home)/.local/bin",
            "\(home)/bin",
            "/opt/homebrew/bin",
            "/usr/local/bin",
            "/usr/bin",
            "/bin",
            "/usr/sbin",
            "/sbin"
        ]
    }

    func locate(_ executable: String) -> String? {
        if executable.hasPrefix("/") && FileManager.default.isExecutableFile(atPath: executable) { return executable }
        return searchPaths.lazy
            .map { URL(fileURLWithPath: $0).appendingPathComponent(executable).path }
            .first(where: FileManager.default.isExecutableFile(atPath:))
    }

    func run(executable: String, arguments: [String], timeout: TimeInterval = 10) async throws -> ShellCommandResult {
        guard let path = locate(executable) else { throw ShellCommandError.executableNotFound(executable) }
        return try await withCheckedThrowingContinuation { continuation in
            let process = Process()
            let stdout = Pipe()
            let stderr = Pipe()
            let gate = CompletionGate()

            process.executableURL = URL(fileURLWithPath: path)
            process.arguments = arguments
            process.standardOutput = stdout
            process.standardError = stderr
            process.terminationHandler = { process in
                let out = String(data: stdout.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
                let err = String(data: stderr.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
                gate.finish(.success(.init(exitCode: process.terminationStatus, stdout: out, stderr: err)), continuation: continuation)
            }
            do { try process.run() } catch { gate.finish(.failure(error), continuation: continuation); return }
            DispatchQueue.global().asyncAfter(deadline: .now() + timeout) {
                if process.isRunning {
                    process.terminate()
                    gate.finish(.failure(ShellCommandError.timedOut), continuation: continuation)
                }
            }
        }
    }
}

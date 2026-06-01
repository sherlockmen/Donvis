# CodeQuota

CodeQuota 是一款面向 Codex 与 Claude Code 用户的 macOS 菜单栏额度监控工具。应用启动后会自动检测正在运行的客户端，并在菜单栏中持续展示 5 小时和 7 天额度，无需手工粘贴数据、填写 API Key 或频繁打开网页。

## 核心特点

- **开箱即用**：自动识别 Codex Desktop、Codex CLI、Claude Desktop 和 Claude Code CLI。
- **双窗口额度**：菜单栏使用上下两条紧凑进度条展示 5 小时和 7 天剩余额度。
- **状态直观**：剩余额度大于 60% 显示绿色，10% 到 60% 显示橙色，低于 10% 显示红色。
- **原生体验**：使用透明 Provider 图标、半透明 Popover 和简洁的 macOS 菜单栏交互。
- **本地优先**：额度数据仅保存在本机，不抓取 Cookie，不上传本地配置。
- **Universal Binary**：同时支持 Apple Silicon 与 Intel Mac。

## 下载安装

下载仓库中的安装镜像：

- [CodeQuota-0.3.0-macOS-universal.dmg](dist/CodeQuota-0.3.0-macOS-universal.dmg)

安装步骤：

1. 打开 DMG。
2. 将 `CodeQuota.app` 拖入“应用程序”。
3. 首次启动时，在 Finder 中右键点击 `CodeQuota.app`，选择“打开”。
4. 在 macOS 安全提示中再次确认。

当前公开安装包使用 ad-hoc 签名，尚未使用 Apple Developer ID 公证。首次启动需要右键打开一次，后续可正常从“应用程序”启动。

安装包 SHA-256：

```text
2338edf5c3b44c01de96dac439557f9c340b52ca371ae25a3d66484a14c66013
```

## 使用方式

打开 CodeQuota 后，应用会出现在菜单栏：

- 左侧图标表示当前活动 Provider。
- `5h` 进度条表示 5 小时窗口剩余额度。
- `7d` 进度条表示 7 天窗口剩余额度。
- 点击菜单栏图标可查看重置时间、最后更新时间和当前连接状态。
- 点击弹窗外部区域会自动关闭 Popover。

设置页支持：

- 登录时启动。
- 本地额度通知。
- Claude statusLine bridge 状态查看。
- 自动监控和隐私说明。

## 自动额度来源

### Codex

CodeQuota 通过官方 `codex app-server` RPC 自动读取 Codex Desktop 或 CLI 的登录状态和额度：

- `account/read`
- `account/rateLimits/read`

应用优先识别 Codex Desktop 自带的可执行文件，同时兼容 PATH、Homebrew、npm 和常见用户目录中的 CLI。

### Claude Code

CodeQuota 会自动备份并合并用户级 `~/.claude/settings.json`，安装 Claude Code 官方 `statusLine` 桥接。桥接仅将 Claude 官方传入的 JSON 原子写入本机：

```text
~/Library/Application Support/CodeQuota/claude-statusline.json
```

如果用户已有 status line，CodeQuota 会继续调用原命令，不会破坏已有终端展示。Claude Desktop 已启动但 Code 会话尚未返回额度时，应用会显示“等待用量更新”。

## 隐私边界

- 不抓取网页 Cookie。
- 不调用未公开接口。
- 不读取会话内容。
- 不扫描无关 Home 目录。
- 不上传额度、账号或本地配置。
- Claude bridge 会在修改前备份 `~/.claude/settings.json`。

## 系统要求

- macOS 13 Ventura 或更高版本。
- Apple Silicon 或 Intel Mac。
- 使用 Codex 时，需要安装 Codex Desktop 或 Codex CLI。
- 使用 Claude Code 时，需要安装 Claude Desktop 或 Claude Code CLI。

## 从源码运行

开发环境需要 Swift 5.9+：

```bash
swift run CodeQuota
```

执行测试：

```bash
swift test
```

仅安装 Command Line Tools 的环境可能缺少 `XCTest` 模块。完整测试建议使用完整 Xcode 工具链。

## 构建与打包

生成 Universal Binary App：

```bash
Scripts/build_app.sh
lipo -info build/CodeQuota.app/Contents/MacOS/CodeQuota
```

生成 DMG、ZIP 和 SHA-256 文件：

```bash
Scripts/package_distribution.sh
```

脚本会分别构建 `arm64` 与 `x86_64`，通过 `lipo` 合并，并执行 ad-hoc 签名完整性校验。

正式公开发布前，建议补充 Apple Developer ID 签名、公证和 GitHub Release 自动化。

## 技术栈

- Swift Package Manager
- SwiftUI
- AppKit `NSStatusItem` / `NSPopover`
- ServiceManagement `SMAppService`
- UserNotifications
- Security Framework

## License

请参阅 [LICENSE](LICENSE)。

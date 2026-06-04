<div align="center">

<p><img src="assets/icon.png" width="96" alt="Donvis"></p>

<h1>Donvis</h1>

<p><b>See your Codex & Claude Code account usage at a glance</b></p>

<p>Lives in the macOS menu bar, automatically detects the official client you're using, and shows your account-level <code>5-hour / 7-day</code> remaining quota in real time.</p>

<p>
  <img alt="platform" src="https://img.shields.io/badge/platform-macOS%2013%2B-black">
  <img alt="arch" src="https://img.shields.io/badge/arch-Apple%20Silicon%20%7C%20Intel-blue">
  <img alt="providers" src="https://img.shields.io/badge/providers-Codex%20%7C%20Claude%20Code-orange">
  <img alt="version" src="https://img.shields.io/badge/version-1.4.0-brightgreen">
  <img alt="license" src="https://img.shields.io/badge/license-MIT-lightgrey">
</p>

<p><a href="README.md">简体中文</a> · <b>English</b></p>

</div>

---

## ✨ What is it

**Donvis** is a local usage monitor built for **Codex** and **Claude Code** users.

No more opening web dashboards, typing commands, or sending a throwaway message first — just open the menu bar and **whichever client you're using shows up with its remaining quota**. Clean and direct.

## 🚀 Key Features

- **🔌 Instant display** — Open it and your current quota is right there. No need to send a message first, no manual trigger — the same experience as the official clients.
- **🧭 Smart client detection** — Automatically distinguishes Codex Desktop, Codex CLI, the Codex VSCode extension, Claude Desktop, and Claude Code CLI. **Whatever is open shows up; close it and it disappears.**
- **📊 Account-level 5h / 7d dual windows** — Shows remaining percentage and reset time for both the 5-hour session window and the 7-day rolling window, so you're never caught off guard.
- **👥 Shared-account merging** — When one account is signed in across multiple clients, Donvis clearly labels it as a shared quota instead of pretending there are several separate allowances.
- **🗂 Clean grouped ordering** — Codex clients and Claude clients are grouped together, with the one you're actively using floating to the top.
- **🔁 Multi-client rotation** — When several clients are online, the menu-bar title rotates between them with a 3D page-flip animation.
- **🪟 Dock fallback** — If macOS hides the menu-bar icon for space, open the same status window from the Dock.
- **🖥 Consistent across displays** — The popup looks and behaves the same on your main and secondary screens.

## 🔒 Privacy first

Donvis only reads the minimum needed to display your quota, and **never touches your code or conversations**:

- Does not scrape web cookies.
- Does not read plaintext API keys from your IDE.
- Does not upload any quota, account, or local configuration data.
- Does not store prompts, model responses, code, or file contents.

## 📦 Download & Install

| Chip | Installer |
| --- | --- |
| Apple Silicon (M-series) | [Donvis-1.4.0-macOS-arm64.dmg](macOS/Donvis-1.4.0-macOS-arm64.dmg) |
| Intel Mac | [Donvis-1.4.0-macOS-x86_64.dmg](macOS/Donvis-1.4.0-macOS-x86_64.dmg) |

Pick the installer matching your Mac's chip — both builds are functionally identical.

**Steps:**

1. Download and open the DMG, then drag `Donvis.app` into Applications.
2. If Gatekeeper blocks the first launch (the build is ad-hoc signed and not Apple-notarized): right-click the app → **Open**, or go to **System Settings → Privacy & Security** and click **Open Anyway**.
3. Alternatively, run `xattr -dr com.apple.quarantine /Applications/Donvis.app` in Terminal, then launch.

> A Windows build is not yet available; it will land in [`Windows/`](Windows/) in a future release.

## 🖼 Screenshots

Donvis shows the current client name and account-level `5h / 7d` remaining quota in the menu bar, rotating automatically when multiple clients are online.

![Donvis menu bar usage](macOS/screenshots/menu-bar-v120.png)

## 💻 Requirements

- macOS 13 Ventura or later
- Apple Silicon or Intel Mac
- For Codex: Codex Desktop, Codex CLI, or the official VSCode extension installed
- For Claude Code: Claude Desktop or Claude Code CLI installed and signed in

## 📄 License

[MIT License](LICENSE)

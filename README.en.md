<div align="center">

<img src="assets/icon.png" width="88" alt="Donvis app icon">

<h1>Donvis</h1>

<p><strong>Let Codex run. Know where you stand.</strong></p>

<p>What quota is left? Which Agent is busy? Where did the time and Tokens go?<br>A glance at the menu bar. A click for the whole picture.</p>

<p>
  <a href="https://github.com/sherlockmen/Donvis/releases/download/v3.2.21/Donvis-3.2.21-macOS-arm64.dmg"><strong>Download for Apple Silicon</strong></a>
  &nbsp;·&nbsp;
  <a href="https://github.com/sherlockmen/Donvis/releases/download/v3.2.21/Donvis-3.2.21-macOS-x86_64.dmg"><strong>Download for Intel</strong></a>
</p>

<p>v3.2.21 · macOS 13+ · Free download · <a href="https://github.com/sherlockmen/Donvis/releases/tag/v3.2.21">Release notes</a></p>

<p><a href="README.md">简体中文</a> · <strong>English</strong></p>

</div>

![Donvis tour using real app stills: the 200-cell context view, task and tool timings, usage breakdowns, and an actual exported share card](assets/v3.2.21/product-tour.gif)

<p align="center"><sub>Meet Donvis in 14 seconds. Edited stills from the real app, rather than a continuous screen recording. All recorded values are unchanged.</sub></p>

**For Mac users who work with Codex every day.** Donvis reads local records from Codex Desktop, Codex CLI, and the official VSCode extension. It uses your existing sign-in, with no separate Donvis account. The current public release focuses on Codex.

[Your menu bar workspace](#a-glance-for-status-a-click-for-your-workspace) · [Plan your quota](#can-you-start-the-next-task-with-confidence) · [The Agent family](#one-task-a-whole-agent-family) · [Follow the time](#long-wait-follow-the-time) · [Get started](#make-room-for-donvis-in-your-menu-bar)

[200-cell context](#200-cells-make-context-space-visible) · [A year's activity](#a-years-activity-a-single-day-in-detail) · [Share cards](#turn-your-work-into-a-card-worth-sharing) · [Membership badges](#a-little-badge-with-its-own-character) · [Native Mac details](#at-home-on-your-mac-down-to-the-details)

## A glance for status. A click for your workspace.

**Check in without breaking your flow.** Donvis lives in the menu bar. Its icon moves while Codex is working, and quota and context indicators rotate every four seconds within a fixed width. Hover for exact Token counts, sample times, and reset times. Choose compact mode for less clutter, or switch between quota used and remaining.

### Work has a rhythm. Your menu bar shows it.

<table>
<tr>
<td align="center"><img src="assets/v3.2.21/menubar/openai-working.gif" width="56" alt="Working icon for low or unrecognized reasoning effort"><br><strong>Low / Default</strong><br><sub>An easy pace</sub></td>
<td align="center"><img src="assets/v3.2.21/menubar/openai-working-medium.gif" width="56" alt="Blue Medium working icon"><br><strong>Medium</strong><br><sub>A blue beat</sub></td>
<td align="center"><img src="assets/v3.2.21/menubar/openai-working-high.gif" width="56" alt="Purple High working icon"><br><strong>High</strong><br><sub>Purple in motion</sub></td>
</tr>
<tr>
<td align="center"><img src="assets/v3.2.21/menubar/openai-working-xhigh.gif" width="56" alt="Orange XHigh working icon"><br><strong>XHigh</strong><br><sub>An orange pulse</sub></td>
<td align="center"><img src="assets/v3.2.21/menubar/openai-working-max.gif" width="56" alt="Rose Max working icon"><br><strong>Max</strong><br><sub>A quicker spin</sub></td>
<td align="center"><img src="assets/v3.2.21/menubar/openai-working-ultra.gif" width="56" alt="Gold Ultra working icon"><br><strong>Ultra</strong><br><sub>A golden rhythm</sub></td>
</tr>
<tr>
<td align="center" colspan="3"><img src="assets/v3.2.21/menubar/openai-working-priorityUltra.gif" width="56" alt="Black and gold working icon for Ultra with faster usage"><br><strong>Ultra + faster usage</strong><br><sub>Black and gold, full tempo</sub></td>
</tr>
</table>

<sub>These are the seven animation resources used by the app, enlarged here. When several main sessions are active, the highest recognized effort sets the icon. Child Agents do not drive the main icon independently. Ultra effort and faster usage are identified separately. The icon shows activity, not task progress.</sub>

### A whole little workspace in 410 × 650

Open the menu bar popover for **quota, reset countdowns, consumption pace, context, today / yesterday Tokens, cache-read share, and model usage**. Keep exploring for main-session and child-Agent activity, tools and skills, reset cards, and credits.

Cards unfold with the popover. The header and action bar stay put while the content scrolls, so your next step is always within reach. Click a usage metric to explore its detail, or jump to trends, usage records, and service accounts from the bottom bar. Sharing, settings, and refresh are close by. Click outside to close it; monitoring continues.

## Can you start the next task with confidence?

“30% left” only tells part of the story. Donvis brings **remaining quota, consumption speed, estimated runtime, and reset time** together so you can plan the next piece of work.

- **See what is available.** Quota windows reflect what the account actually returns. Switch between used and remaining, follow the status colors, and choose a reset timestamp or a flip clock counting down days, hours, minutes, and seconds.
- **See how far it might go.** Four cards show hourly consumption, estimated runtime, average allowance until reset, and usage guidance. Compare the consumption-to-allowance ratio, with historical model and effort settings as options to consider. Hover to check the observation period and supporting samples.
- **See what changed.** Explore today, seven days, or 30 days of quota and credit history. Distinguish scheduled resets, confirmed reset-card use, and recoveries whose source is unconfirmed. Range highs and lows, sample counts, and the latest update are recorded too. Toggle series in the legend and hover for exact values.
- **Hear about the moments that matter.** Separate notifications cover low quota, critical quota, exhaustion, confirmed resets, and recovery. Set your thresholds. Each window is evaluated independently, with repeat alerts suppressed within the same cycle. Available reset cards also receive 72-hour and 24-hour expiry reminders.

<details>
<summary>See real quota and credit history</summary>

![Actual quota and credit-balance samples, with reset markers and hover details](assets/v3.2.19/quota-credit.jpg)

</details>

<sub>Runtime and pace are estimates from observed consumption. Historical speed used for a new cycle is labeled; insufficient samples keep the estimate in a waiting state. Notifications require system permission. Reset and recovery alerts depend on data actually received.</sub>

### Put your reset cards to use before they expire

![Real account resources: available reset cards, individual expiry details, runtime estimates after a reset, and the credit balance](assets/v3.2.19/account-resources.jpg)

**How many are available? Which expires first? Would using one help now?** Reset cards are sorted by expiry, with both the date and time remaining. Their color changes as expiry approaches. With enough consumption samples, Donvis can estimate how long a fully restored quota might last. Credit balance, observed consumption, and history stay alongside your cards.

“Go to reset” opens the official page; you decide whether to use a card. Card details that have not yet synced are clearly marked. Missing data is never presented as zero cards or an expired card.

## One task. A whole Agent family.

Handing work to several Agents feels great. A single total at the end tells you much less. **Expand a main session in Donvis to see the Agent family behind it.**

![Real interaction: expanding a session family to inspect child Agents, models, effort, and Token details](assets/v3.2.18/session-tour.gif)

- **Three totals, clear ownership.** See the main session's own usage, child Agents combined, and the inclusive total separately. Follow parent relationships through multiple Agent levels without mistaking a team total for the main session's own usage.
- **Recognize each member.** Session titles, Agent nicknames, stable avatars, models, and reasoning effort appear together. Hovering summary metrics can open the corresponding member list, so you can keep following the source.
- **Break down the Tokens.** Input, cache reads, cache writes where recorded, output, and reasoning each have a place. Reasoning is part of output and is not added twice.
- **Go back to the work.** Search session titles and load more records. Open supported threads directly in Codex with “Open chat.” Auxiliary execution and interactive sessions are shown separately.

Switch scope to compare main sessions and child Agents. Main-session scope counts user messages; child-Agent scope counts distinct model responses. Move between time periods and explore models, message counts by client, message composition, a tool-call treemap, and skill-read rankings. Move from “how much?” to “how was it used?”

<sub>Session ownership depends on recognizable local records. Skill rankings count detected SKILL.md reads, rather than complete skill executions. “Open chat” requires the Codex URL protocol to be registered on your Mac.</sub>

## 200 cells make context space visible

How far has a long chat grown? How much room is left? **Each cell represents 0.5%; all 200 show the current context capacity.** The last cell can be partly filled. Colors change with occupancy, and hover details show the precise Token range, used capacity, and remaining space.

![Real context and work views: 200-cell capacity, sample and compaction times, the work/idle timeline, and performance summaries](assets/v3.2.21/context.jpg)

The last sample and latest confirmed compaction time stay visible, so you can judge how fresh the reading is. Beside it, **work and idle time** turn recognized task activity into a timeline. See when Codex was busy today, or review daily activity shares across seven or 30 days. Overlapping tasks count elapsed time once.

<sub>Context comes from the latest main-session request, rather than cumulative Tokens across all chats. Idle time includes unobserved periods. This view describes Codex task activity, not personal working hours or productivity.</sub>

## Long wait? Follow the time.

**Was it the first Token, a slow tool, or context compaction?** Start with the overview, then follow the evidence into individual tasks.

![Real performance analysis: task durations in occurrence order, tool and command-family rankings, reasoning composition, and context compactions](assets/v3.2.21/performance.jpg)

| What you want to understand | Where to look next |
| --- | --- |
| **How long until a response starts?** | Median time to first Token and full-turn duration, based on successful completions. Hover for P95, valid samples, expected turns, and coverage. |
| **Which task took so long?** | One bar per task, in occurrence order. Titles and available opening-message excerpts help identify it. Drag the range slider to focus on a section. Seven-day and 30-day views add daily totals and average duration. |
| **Which tools used the time?** | Calls by tool and command family, cumulative duration for fully timed executions, and recent main operations. Page through the rest. |
| **When was context compacted?** | One bar per event, with its timing basis retained and a range slider to zoom in. Seven-day and 30-day views also show compaction's share of time each day. |
| **How many sessions were running together?** | Tasks in progress, the peak within the selected interval, overlap time, and its distribution over time. Inspect main sessions and child Agents separately. |
| **How were effort and speed tiers used?** | Reasoning versus regular-output Tokens, recorded task-duration shares by reasoning effort, and faster usage shown separately. |

Failure counts, failure rates, and stopped tasks are tracked separately. Coverage stays next to the metrics, with explanations for missing records.

<sub>Full-turn duration includes tools and waiting. Cumulative tool durations can overlap. Parallelism describes task activity intervals, including tasks still running at the sample time. It does not measure concurrent model requests. Status is as of the last sample.</sub>

## A year's activity. A single day in detail.

![Real seven-day usage: Token totals and composition, date selection, and session details](assets/v3.2.18/usage.png)

**Start with the yearly heatmap, then open the day that catches your eye.** Today shows hourly changes; seven-day and 30-day views show trends. The yearly view adds a heatmap, annual Tokens, and days with records. Switch years or return to the current one. Selecting a date updates the summaries and sessions; clearing it restores the original range.

Which project or model drove the usage? Compare the top five models and the rest, project usage areas, and session distribution. Message activity can be compared separately across Desktop, CLI, and VSCode. Today / yesterday comparisons, cumulative Tokens, the busiest day, the longest task, and current and longest usage streaks give your records a longer view.

**API reference costs are your choice.** Enable estimates and enter model prices for input, cache reads, cache writes, and output. Compare them against a monthly reference budget. Records without a price stay marked unpriced. Export CSV or JSON for the selected range and date when you want to explore further.

<sub>Reference costs are not subscription charges, and the reference budget does not enforce a limit. Amounts use your saved prices. Official quota, local Tokens, and reference estimates remain separate.</sub>

## Turn your work into a card worth sharing

Choose today, seven days, or 30 days, then **copy the image or save a PNG**. The card is generated on your Mac with aggregate Token totals and their composition, plus session and model counts. Email addresses, project names, session titles, and conversation text stay out. You decide whether to share it, and with whom.

<img src="assets/v3.2.21/usage-share.png" width="800" alt="Seven-day share card exported by Donvis, with aggregate Token totals and composition and no account or project names">

## A little badge with its own character

Go, Plus, Pro 100 / 200 / 500, and Pro 5× / 20× each get their own colors, symbol, and detail plate. **A black-and-gold gem for Pro 200. A crown for Pro 500. Small details deserve care, too.** Sizes fit both the workspace and popover, with light and dark appearances and full membership names for screen readers.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/v3.2.21/membership-dark.png">
  <img src="assets/v3.2.21/membership-light.png" width="900" alt="Native Donvis membership badge gallery: Go, Plus, Pro 100, Pro 200, Pro 500, Pro 5×, and Pro 20×">
</picture>

<sub>This gallery is rendered natively from the app's production components to show the built-in styles. It is not a screenshot of seven accounts. Badges represent Codex account memberships; Donvis does not sell these subscriptions.</sub>

## At home on your Mac, down to the details

**Quietly in the menu bar. One shortcut away.** A resizable native window comes with the standard Mac window controls. Close it and monitoring continues. Choose launch at login, hide the Dock icon, keep the window on top, or record your own global shortcut.

**Made to explore.** Hover charts for full names and exact values, with readable tooltips that can extend beyond a card. Toggle legend items, focus an interval with the range slider, and scroll the page naturally as your trackpad crosses a chart. Capsule selectors slide and spring back, disclosure rows are clickable across the whole row, and cards and charts enter when their data is ready.

**Comfort follows your system settings.** Glass, rounded corners, and fine borders carry through to the popover. Donvis respects Reduce Motion and Reduce Transparency. Key controls, charts, and badges include screen-reader labels.

| The little things | Fewer detours, more clarity |
| --- | --- |
| **Keyboard access** | ⌘1…⌘5 switch workspace pages. ⌘R refreshes. ⌘, opens settings. Record your own global show / hide shortcut. |
| **Multiple account directories** | Link existing signed-in Codex configuration directories. Switch their quota, context, and work records, or refresh all accounts. Removing a link preserves the original files. Local Token history is not fully separated by account. |
| **Visible clients** | Identify Desktop, CLI, and the official VSCode extension. Check running state, process count, resident memory, and the latest scan time. Donvis excludes its own probes from your CLI activity. |
| **Disk usage with a breakdown** | See logical sizes, proportions, and measurement times for sessions, child Agents, archives, unclassified files, worktrees, and other files. Recalculate when needed. Disk usage is separate from process memory. |
| **Your preferred order** | Show, hide, sort, pin, or rotate services every 5 / 10 / 30 / 60 seconds. Search and filter the service catalog by category, connection, enabled state, or configuration needed, with official links and setup help. Other platforms are still being tested. |
| **A sensible background rhythm** | Automatic quota refresh adapts to activity and pauses while the screen is locked. Local records are scanned incrementally, and hidden popover content is unloaded. Scan progress, update times, cached-data labels, and read-error states help explain the data. |
| **Take records with you** | Export Token CSV / JSON, quota-history JSON, or redacted diagnostics. Clear local quota history after confirmation. Check LAN snapshot and iCloud capability status in settings. |

## Make room for Donvis in your menu bar

1. **Download and install.** Choose [Apple Silicon / M-series](https://github.com/sherlockmen/Donvis/releases/download/v3.2.21/Donvis-3.2.21-macOS-arm64.dmg) or [Intel](https://github.com/sherlockmen/Donvis/releases/download/v3.2.21/Donvis-3.2.21-macOS-x86_64.dmg). Open the DMG and drag `Donvis.app` into Applications.
2. **Use your existing Codex sign-in.** Install and sign in to Codex Desktop or Codex CLI first, then open Donvis. Check “Connected tools” to confirm client detection.
3. **Let the first data arrive.** Account quota requires a network connection and a valid sign-in. The first local scan reads your logs; history curves build over time. Set your preferred display, alerts, and shortcuts, and get to work.

<p align="center"><strong>Next time Codex gets to work, keep the picture in view.</strong><br><br><a href="https://github.com/sherlockmen/Donvis/releases/latest"><strong>Download Donvis free →</strong></a></p>

<details>
<summary>Installation and compatibility</summary>

The main app requires macOS 13+. Some optional extension components require macOS 14+. Apple Silicon and Intel packages are available. Both architectures have build and package checks, with Intel CLI checks under Rosetta. Native Intel hardware and macOS 13 have not yet been tested. There is no Windows release.

The current package is ad-hoc signed and has not been notarized with Apple Developer ID. If macOS blocks it, verify the download source and review the Donvis notice in System Settings → Privacy & Security. This release has no iCloud entitlement and cannot sync through iCloud.

</details>

<details>
<summary>Data, privacy, and statistical scope</summary>

- **Official quota and local records answer different questions.** Donvis uses your existing sign-in through Codex app-server to fetch quota and account resources online. Token, project, session, and performance views come from logs on this Mac, rather than every device on the account. If one quota window is returned, one is shown. Missing records, missing responses, and zero usage have distinct states.
- **LAN snapshots are enabled by default.** The service listens on port 4100. Devices on the same network can read snapshots without authentication. They can include account labels, device names, and client information, but no conversation text or keys. Turn it off in Settings → iPhone & LAN if you do not need it.
- **Review exports before sharing.** Token CSV / JSON excludes conversation text, account identifiers, and keys, but includes project names, models, and anonymous session identifiers. Quota-history JSON may include account labels. Share cards keep only aggregate data. Exporting diagnostics does not upload them automatically.
- **The evidence sets the scope.** Performance metrics depend on recognizable logs with timing records. Some details read local session titles and opening-message excerpts. Budgets provide a reference comparison; tool and skill counts are not a complete behavior audit. Donvis observes and analyzes. It does not dispatch tasks, change models, or redeem reset cards for you.

</details>

<details>
<summary>Where the demo media comes from</summary>

The opening tour edits stills from the running v3.2.21 app. Context and performance images and the share card also come from this round of real-app capture. The session-expansion GIF, usage image, and account-resource images reuse real v3.2.18 / v3.2.19 media. Identifying information has been removed; recorded values are unchanged. The seven animations are original app resources. The membership gallery is rendered natively from production components and labeled accordingly.

</details>

[Report an issue](https://github.com/sherlockmen/Donvis/issues) · [Past releases](https://github.com/sherlockmen/Donvis/releases) · [MIT License](LICENSE)

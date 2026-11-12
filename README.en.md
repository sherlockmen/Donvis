<div align="center">

<img src="assets/icon.png" width="80" alt="Donvis app icon">

<h1>Donvis</h1>

<p><strong>Let Codex run. Keep track from your menu bar.</strong></p>

<p>Quota left. Agents at work. Where the time and Tokens went.<br>A glance to check in. A click to follow the details.</p>

<p>
  <a href="https://github.com/sherlockmen/Donvis/releases/download/v3.2.27/Donvis-3.2.27-macOS-arm64.dmg"><strong>Download for Apple Silicon</strong></a>
  &nbsp;·&nbsp;
  <a href="https://github.com/sherlockmen/Donvis/releases/download/v3.2.27/Donvis-3.2.27-macOS-x86_64.dmg"><strong>Download for Intel</strong></a>
</p>

<p>v3.2.27 · macOS 13+ · Free download · Uses your Codex sign-in</p>

<p><a href="README.md">简体中文</a> · <strong>English</strong></p>

</div>

<p align="center"><img src="assets/showcase-20261105/menu-bar-tour.gif" width="442" alt="The real Donvis menu bar popover: opening, switching between today and yesterday, then scrolling through quota, reset cards and context"></p>

<p align="center"><sub>Open your menu bar. Keep what matters within reach. Real interactions at original speed, excerpted with recorded values preserved and identifying information removed.</sub></p>

**For Mac users who work with Codex every day.** Donvis reads local records from Codex Desktop, Codex CLI, and the official VSCode extension. No separate Donvis account is needed. The current public release focuses on Codex.

[Check in](#a-glance-for-status-a-click-for-the-details) · [Plan your quota](#plan-the-next-task-with-your-quota-in-view) · [Follow usage and waiting](#follow-the-tokens-find-the-wait) · [Review your activity](#todays-activity-with-a-longer-view) · [Get started](#make-room-for-donvis-in-your-menu-bar)

## A glance for status. A click for the details.

**Fewer window switches. Fewer breaks in your train of thought.** Quota and context indicators rotate within a fixed menu bar width. Hover for exact Token counts, sample times, and reset times. Click to open a 410 × 650 workspace with today / yesterday usage, cache-read share, models, main sessions and child Agents, tools and skills, and account resources.

**Give a long chat's remaining space a shape.** The context view has 200 cells, each representing 0.5%. The last cell can be partly filled. Hover for precise Token ranges and used / free capacity. The workspace shows sample and compaction times so you can judge how fresh the reading is.

Cards unfold with the popover. The middle scrolls while the header and action bar stay put. Click a metric to explore it, or jump to trends and records from the bottom bar. Sharing, settings, and refresh are close by. Click outside to close it; monitoring continues.

### Work has a rhythm. Small details show it.

<p align="center">
<img src="assets/v3.2.21/menubar/openai-working.gif" width="36" alt="Low or unrecognized effort">
<img src="assets/v3.2.21/menubar/openai-working-medium.gif" width="36" alt="Medium in blue">
<img src="assets/v3.2.21/menubar/openai-working-high.gif" width="36" alt="High in purple">
<img src="assets/v3.2.21/menubar/openai-working-xhigh.gif" width="36" alt="XHigh in orange">
<img src="assets/v3.2.21/menubar/openai-working-max.gif" width="36" alt="Max in rose">
<img src="assets/v3.2.21/menubar/openai-working-ultra.gif" width="36" alt="Ultra in gold">
<img src="assets/v3.2.21/menubar/openai-working-priorityUltra.gif" width="36" alt="Ultra with faster usage in black and gold">
</p>

Seven working animations follow recognized main-session effort, from a gentle turn to a quick black-and-gold rhythm. Memberships have their own character too: **a black-and-gold gem for Pro 200, a crown for Pro 500**. Go and Plus each have distinct symbols; Pro 100 and 5× / 20× pair their symbols with number plates.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/showcase-20261105/membership-dark.png">
  <img src="assets/showcase-20261105/membership-light.png" width="420" alt="Built-in Donvis membership badge gallery: Go, Plus, Pro 100, Pro 200, Pro 500, Pro 5×, and Pro 20×">
</picture>



<details>
<summary>At home on your Mac, down to the details</summary>

- **Quietly within reach.** A resizable native window has standard Mac controls. Close it and menu bar monitoring continues. Choose launch at login, hide the Dock icon, keep the window on top, or record your own global shortcut.
- **Keyboard access.** ⌘1…⌘5 switch workspace pages. In Overview, ⌘R refreshes account quota and local usage together. ⌘, opens settings. Choose a compact menu bar, used / remaining quota, and indicators that rotate every four seconds. Pin a service or rotate services every 5 / 10 / 30 / 60 seconds.
- **Charts made to explore.** Native tooltips show full names and exact values, even beyond a card's edge. Toggle legend items or drag a range slider to focus on an interval. Your trackpad still scrolls the page across a chart, and interactive tooltips let you move inside for a closer look.
- **A feel that follows your system.** Capsule selectors slide and spring back, disclosure rows are clickable across the whole row, and cards and charts enter when their data is ready. Glass, rounded corners, and light / dark appearances stay consistent. Reduce Motion, Reduce Transparency, and screen-reader labels are supported.
- **A background rhythm.** Automatic quota refresh adapts to activity and pauses while the screen is locked. Local records are scanned incrementally, and hidden popover content is unloaded. Scan progress, update times, cached-data labels, and available error states help explain the readings.

<sub>The animations are original app resources, not progress indicators. The highest recognized effort among active main sessions sets the icon; child Agents do not drive it independently. Ultra and faster usage are identified separately. The badge gallery is rendered natively from production components, rather than captured from seven accounts. Badges represent Codex memberships.</sub>

Context comes from the latest main-session request, rather than cumulative Tokens across every chat. Missing samples have an explanation; unknown capacity is not presented as zero usage.

</details>

## Plan the next task with your quota in view

**Put “how long might it last?” next to “how much is left?”** Four cards bring together hourly consumption, estimated runtime, average allowance until reset, and usage guidance. Colors show quota pressure. Choose a reset timestamp or a flip-style countdown.

<p align="center"><img src="assets/showcase-20261105/quota-planning.jpg" width="560" alt="A collage of four real quota cards: hourly consumption, estimated runtime, average allowance until reset, and usage guidance"></p>

<p align="center"><sub>Editorial layout of four cards from the same real screen. Recorded values are unchanged.</sub></p>

**Remember your reset cards before they expire.** Available counts, individual expiry dates, time remaining, and estimated runtime after a reset sit together. The earliest expiry comes first, colors flag approaching deadlines, and reminders cover the 72-hour / 24-hour thresholds. “Go to reset” opens the official page; you decide whether to use a card. Credit balance and observed consumption stay alongside it.

Low quota, critical quota, exhaustion, confirmed resets, and recovery each have alerts. Today / seven-day / 30-day quota and credit charts show how usage fell and when it recovered, without repeatedly checking one percentage.

<details>
<summary>From a reading to a plan with evidence behind it</summary>

![A close look at real reset cards and credit resources](assets/showcase-20261105/account-resources.jpg)

- **Your account sets the scope.** Only quota windows actually returned by the service are shown. Switch between used and remaining, with update times, cached-data labels, and available error states preserved. Unsynced card details are labeled, rather than presented as zero cards or expired cards.
- **Check the estimate.** Hover for the observation period, sample count, and measured decline. Compare consumption with average allowance, or consult completed-task samples for historical models and effort levels. Historical speed used for a new cycle is labeled; insufficient samples keep the estimate waiting.
- **Review the changes.** Charts distinguish scheduled resets, confirmed card use, and recoveries with an unconfirmed source. Filter series in the legend and hover for exact values. Range highs and lows, sample counts, and the latest update are recorded. Cumulative credit consumption depends on locally retained samples.
- **Alerts respect each window.** Adjust thresholds, evaluate windows separately, and suppress repeat alerts for the same account, window, and cycle. Recovery requires received data to confirm it. Alerts must be enabled and have system notification permission.
- **Less back and forth between accounts.** Link existing signed-in Codex configuration directories. Switch quota, context, and work records, or refresh every account. Removing a link preserves the original files. This does not change other CLI sign-ins, and local Token history is not fully separated by account.

Predictions use observed consumption. They do not guarantee task completion or an exact exhaustion time, and they do not count future quota resets in advance. Donvis does not redeem cards automatically. Export quota history as JSON, or clear local history after confirmation.

</details>

## Follow the Tokens. Find the wait.

**Expand one total into the Agent family behind it.** See the main session's own usage, child Agents combined, and the inclusive total separately. Titles, nicknames, stable avatars, models, and reasoning effort help you recognize each member. Follow parent relationships through deeper delegation.

![Real interaction: expanding main sessions and child Agents, inspecting models, effort, Token details, and the Open chat entry](assets/v3.2.18/session-tour.gif)

Inspect input, cache reads, cache writes where recorded, output, and reasoning. Find a high-usage session, search its title, and open valid threads directly in Codex. A tool-call treemap, message composition, and skill-read rankings help explain how the work happened.

**Waiting leaves clues too.** Check time to first Token separately from full-turn duration. Follow a duration bar to an individual task. Inspect tool and command-family rankings, context-compaction records, and Agent parallelism to see which sessions were active together.

<details>
<summary>Keep following the samples, tasks, and tools</summary>

![Real task durations and tool-execution rankings, shown up close](assets/showcase-20261105/analysis.jpg)

- **Separate main sessions from child Agents.** Choose today, seven days, or 30 days, and move between historical periods in session analysis. Main-session scope counts user messages; child-Agent scope counts distinct model responses. Auxiliary execution is listed separately. Summary metrics reveal session, Agent, model, and project lists, with title search and more records to load.
- **Keep Token ownership clear.** Cache reads and uncached input have separate places. Reasoning is part of output and is not added twice. Inspect reasoning / regular-output composition, recorded task-duration shares by reasoning effort, and faster usage separately.
- **See duration shares while tasks run.** Reasoning-effort and faster-usage shares include tasks in progress, up to the latest sample. Parallel tasks accumulate separately; settings without enough evidence appear under Other. The cards show durations and shares directly.
- **See the coverage behind the number.** First-Token and full-turn summaries use successful completions. Hover for medians, P95, valid samples, expected turns, and coverage. Failure counts, failure rates, and stopped tasks are tracked separately.
- **Follow a bar to a task.** Today's timed tasks appear in occurrence order, with titles and available opening-message excerpts to help identify them. Drag the range slider to zoom in. Seven-day / 30-day views offer daily totals or average task duration. Compactions have separate timings, with daily compaction-duration shares in longer views.
- **Go beyond a tool name.** Check call counts, cumulative duration for fully timed executions, command families, recent main operations, and clues from recent sessions. Page through more tools. Compare message activity by model / client, and inspect detected SKILL.md read requests in skill rankings.
- **Put parallel activity on a timeline.** Inspect tasks in progress, the interval peak, overlap time, and its distribution. Main sessions and child Agents have separate scopes. Status is as of the last sample.

Ownership and timing depend on recognizable local records. “Open chat” needs a valid thread and the Codex URL protocol on your Mac. A skill read is not a complete skill execution. Full-turn duration includes tools and waiting; cumulative tool durations can overlap. Overlapping task intervals do not measure concurrent model requests.

</details>

## Today's activity, with a longer view

**Find a busy day, then open it to see why.** Today shows hourly changes. Seven-day / 30-day views show totals and composition; the yearly heatmap gives you the longer view. Select a date to filter summaries and sessions, then follow models and projects to see where the Tokens went.

![Real seven-day usage: totals and daily Token composition, with dates that open further detail](assets/showcase-20261105/usage.jpg)

Today / yesterday comparisons, yearly Tokens, recorded days, the busiest day, the longest task, and usage streaks give daily activity a longer perspective. Work / idle timelines connect recognized tasks, with daily activity shares across seven or 30 days.

**Keep a card of your activity.** Choose today, seven days, or 30 days, then copy the image or save a PNG. Token totals and composition, session counts, and model counts stay in. Email, project names, session titles, and conversation text stay out. Export CSV / JSON to explore further, or use your own model prices for API reference costs.

<details>
<summary>Your usage record, with room to explore further</summary>

<img src="assets/v3.2.21/usage-share.png" width="660" alt="Seven-day share card exported by the real app, without email, project names, or conversation text">

- **From a year to a day.** Switch years or return to this year. Select a date to filter usage and sessions, then clear it to restore the original range. Cumulative Tokens and current / longest usage streaks come from records read on this Mac.
- **Compare different views of the work.** Model rankings separate the top five from the rest. Project Token areas and project distributions by session count show different perspectives. Message activity across Desktop / CLI / VSCode is compared separately.
- **Set your own reference costs.** Enable API estimates and enter model prices for input, cache reads, cache writes, and output. Missing prices stay marked unpriced. Compare estimates against a monthly reference budget. This is not a subscription bill and does not enforce a spending limit.
- **Export the range you selected.** Save Token CSV / JSON for a range or selected date. Exports exclude conversation text, account identifiers, keys, and full paths, but retain project names, models, and anonymous session identifiers. Quota-history JSON may include account labels. Share cards are generated locally; you decide whether to send them anywhere.
- **See where local resources go.** Inspect logical disk sizes, proportions, measurement times, and partial-read status for sessions, child Agents, archives, unclassified files, worktrees, and other files. Recalculate when needed. Client views separately show running state, resident memory, process counts, and scan time. Donvis excludes its own probes from your CLI activity.
- **Find setup and support in one place.** Show, hide, and sort services. Search or filter the catalog by category, connection, enabled state, or configuration needed, with official links and setup help. Other platforms are still being tested. Settings show LAN snapshot and iCloud capability status and offer redacted diagnostic JSON export. Exporting does not upload it automatically.

Work time merges recognized task intervals. Idle includes unobserved periods, so this describes Codex activity rather than personal working hours or productivity. Disk usage and process memory are separate measurements; there is no automatic cleanup or memory-release feature.

</details>

## Make room for Donvis in your menu bar

1. **Download and install.** Choose [Apple Silicon / M-series](https://github.com/sherlockmen/Donvis/releases/download/v3.2.27/Donvis-3.2.27-macOS-arm64.dmg) or [Intel](https://github.com/sherlockmen/Donvis/releases/download/v3.2.27/Donvis-3.2.27-macOS-x86_64.dmg). Open the DMG and drag `Donvis.app` into Applications.
2. **Use your Codex sign-in.** Install and sign in to Codex Desktop or Codex CLI first, then open Donvis. “Connected tools” confirms client detection.
3. **Let the first data arrive.** Quota needs a network connection and valid sign-in. The first local scan reads your logs; history builds over time. Set your preferred display, alerts, and shortcuts, and get started.

<p align="center"><strong>Next time Codex gets to work, keep the picture in view.</strong><br><br><a href="https://github.com/sherlockmen/Donvis/releases/latest"><strong>Download Donvis free →</strong></a></p>

<details>
<summary>Compatibility, data, and privacy</summary>

- **System and packages.** The main app requires macOS 13+. Some extension components require macOS 14+. Both architectures have build and package checks, with Intel CLI checks under Rosetta. Native Intel hardware and macOS 13 have not yet been tested. There is no Windows release.
- **Signing and cloud capabilities.** The current package is ad-hoc signed and has not been notarized with Apple Developer ID. If macOS blocks it, verify the download source and review the Donvis notice in System Settings → Privacy & Security. This release has no iCloud entitlement and cannot sync through iCloud.
- **Two data sources, different questions.** Account quota and resources are fetched online through Codex app-server using your existing sign-in. Tokens, projects, sessions, and performance come from logs on this Mac, rather than every device on the account. Some details temporarily read local session titles and opening-message excerpts. Missing records or an unfinished scan affect coverage.
- **LAN snapshots are enabled by default.** The service listens on port 4100. Same-network devices can read snapshots without authentication. Snapshots can contain account labels, device names, and client information, but no conversation text or keys. Turn the service off in Settings → iPhone & LAN if you do not need it.
- **Observation and analysis.** Donvis does not send tasks, change models, or redeem reset cards for you. Predictions, reference estimates, and statistics each have their own data sources. They do not guarantee task completion, savings, or improved productivity.

</details>

<details>
<summary>About the demo media</summary>

App views come from running Donvis instances. Recorded values are unchanged, and identifying information has been removed. The menu bar popover comes from this real-device recording. Other screenshots and the session GIF reuse real material from earlier releases, with their original dates and values. The seven working animations are original app resources. The membership gallery is rendered natively from production components, rather than captured from multiple accounts.

</details>

[Release notes](https://github.com/sherlockmen/Donvis/releases/tag/v3.2.27) · [Report an issue](https://github.com/sherlockmen/Donvis/issues) · [Past releases](https://github.com/sherlockmen/Donvis/releases) · [MIT License](LICENSE)

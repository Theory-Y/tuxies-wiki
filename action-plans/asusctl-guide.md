# Action Plan — ASUS Control Guide (asusctl + ROG Control Center)

New guide covering `asusctl` (the CLI/daemon) and `asusctl-rog-gui` / ROG Control Center (the GUI)
for ASUS ROG / TUF laptops on Linux. Power-management focused (Platform Profile, EPP, AC/battery
auto-switch) with install-from-scratch for **Fedora (Terra)**, **Debian/Ubuntu**, and **Arch**, plus
an ==incredibly brief== WM section on the Dank/ASUS Control shell plugins.

Analogous to the existing **GPU Guide** (`docs/guides/gpu.md`) — same "hardware daemon + GUI + GNOME/WM
toggle" shape. Reuse that structure and tone.

## Maintainer decisions — LOCKED (2026-07-18)

1. **Title / permalink** — ✅ `ASUS Laptop Control (asusctl)`, permalink `/guides/asusctl/`,
   file `docs/guides/asusctl.md`.
2. **Debian/Ubuntu** — ✅ ship honestly: it is **build-from-source only** (upstream unpackaged,
   "coming soon"). Do ==not== inline the full dep dump — a short `:::warning` + a link straight to the
   **official GitHub build instructions** (`OpenGamingCollective/asusctl` README). One command hint at
   most; let the repo be the source of truth for the build.
3. **Screenshots** — ✅ **text-first**. Write the guide with no images; leave the image slots (last per
   entry order) as flagged TODOs. Tracked as an image-backfill item in ROADMAP **Deferred** — and
   `gnome-further-customisation.md` is flagged for image backfill in the same item.
4. **Beginner / GUI-first** — ✅ this is a ==beginner's guide==. Lead with ROG Control Center (the GUI)
   for every task; keep raw sysfs/CLI to a minimum. Mention `asusctl --help` / `asusctl profile --help`
   as the "want the terminal?" pointer instead of documenting version-specific set flags.

## Verified upstream facts (do not invent — sourced from asus-linux.org, GitHub README, ArchWiki, slint UI)

### What it is
- `asusctl` = daemon (`asusd`) + CLI + `rog-control-center` GUI for ASUS ROG/TUF laptops. Supersedes
  `rog-core`. D-Bus interface `xyz.ljones.Platform`.
- Controls: **Platform Profile / Throttle Policy**, **EPP**, fan curves, AniMe/Aura LEDs, battery
  charge limit, AC/battery profile auto-switch.

### Power-management model (the guide's core — all verified in this session)
- **Platform Profile** (aka Throttle Policy) — top-level mode written to kernel
  `/sys/firmware/acpi/platform_profile`. Values: `Quiet`, `Balanced`, `Performance` (some models add
  `LowPower`, `Custom`). Sets fan curve + CPU/GPU power limits + thermal target.
- **EPP (Energy Performance Preference)** — CPU-level tuning inside a profile. Values `power`,
  `balance_power`, `balance_performance`, `performance`. Sysfs:
  `/sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference`.
- **Linked EPP** — GUI toggle **"Energy Performance Preference linked to Throttle Policy"**
  (config `platform_profile_linked_epp`). ON = each profile auto-applies its paired EPP. Per-profile
  EPP dropdowns: "EPP for Balanced/Performance/Quiet Policy" (`profile_*_epp`).
- **AC/battery auto-switch** — GUI section **"Throttle Policy for power state"** with two
  toggle+dropdown pairs: **"Throttle Policy on AC"** / **"Throttle Policy on Battery"**
  (config `change_platform_profile_on_ac` / `_on_battery` + `platform_profile_on_ac` / `_on_battery`).
  → This is the automation the guide teaches: Performance on AC, Quiet on battery, EPP follows.
- ==All of the above is doable entirely in the GUI== (verified against `rog-control-center` `system.slint`).

### power-profiles-daemon (ppd) coexistence — IMPORTANT beginner gotcha
- Niri/GNOME/KDE Quick-Settings power toggle (Power Saver/Balanced/Performance) talks to
  `power-profiles-daemon` via `org.freedesktop.UPower.PowerProfiles`.
- Both ppd and `asusd` write the **same** `platform_profile` sysfs node → they can fight
  (documented: set Performance in one, the other flips to power-saver). Modern `asusd` implements the
  ppd D-Bus interface so the desktop toggle routes through `asusd`.
- Fedora Terra guide's own advice: `sudo dnf swap tuned-ppd power-profiles-daemon --allowerasing`
  then `systemctl enable --now power-profiles-daemon.service`. Run **one** profile owner.

### CLI — GUI-first guide, so keep this light (beginner audience)
- Everything the guide teaches is done in the GUI. CLI is an optional aside only.
- Point terminal-curious readers at `asusctl --help` and `asusctl profile --help` rather than
  documenting version-specific set flags (they drift between releases).
- Safe-to-show reads: `asusctl profile -p` (current profile), and for the "verify" section a couple of
  plain checks — `cat /sys/firmware/acpi/platform_profile`, power source
  `cat /sys/class/power_supply/A*/online` (1=AC), daemon log `journalctl -u asusd -f`. Wrap the deeper
  sysfs/EPP paths in `::::details` so beginners aren't forced through them.

### Install — per distro
- **Fedora (Terra):** Terra repo is ==already documented in `linux-guides/fedora.md`== → cross-link,
  don't re-teach. Then:
  ```bash
  sudo dnf install asusctl asusctl-rog-gui
  systemctl enable --now asusd.service
  # if stock tuned-ppd is present:
  sudo dnf swap tuned-ppd power-profiles-daemon --allowerasing
  systemctl enable --now power-profiles-daemon.service
  ```
  (Old `lukenukem/asus-linux` COPR is dead — mention only to tell users to remove it.)
- **Arch:** `asusctl` is in the official `extra` repo; `rog-control-center` is AUR (`rog-control-center`,
  6.3.8) or the upstream **g14** repo. Beginner path:
  ```bash
  sudo pacman -S asusctl
  yay -S rog-control-center        # AUR
  systemctl enable --now asusd.service
  ```
  Note the **g14 repo** as the upstream-official (precompiled, maintained) alternative — a `:::tip`
  link to `asus-linux.org/guides/arch-guide/` rather than re-teaching pacman-key setup inline.
- **Debian/Ubuntu:** ==not officially packaged== ("coming soon" upstream) → **build from source**.
  Ship honestly: a short `:::warning` (no official package; you compile it yourself) + a link straight
  to the **official build instructions** in the `OpenGamingCollective/asusctl` README. Do ==not== dump
  the full dep list inline (it drifts and differs Ubuntu vs Pop!) — the repo is the source of truth.
  At most show the tail once built: `make && sudo make install` then
  `systemctl enable --now asusd.service`.

### WM plugins section (keep it ==incredibly brief== — a few lines + links, no install walkthrough)
- **Dank ASUS Control Center** — by **Shazzaam**, repo `shazzaam7/DankAsusControl`. A
  **DankMaterialShell** (Quickshell) plugin that surfaces `asusctl` + `supergfxctl` power profiles +
  GPU modes in the DankBar. In the DMS plugin registry → install with
  `dms plugins install dankAsusControlCenter`. Deps: `asusctl`, `supergfxctl`, `upower`. This is the
  primary one to feature.
- Alternative worth a one-line mention: **ASUS Control** (`pseudofractal/AsusControl`), a separate DMS
  plugin covering the same ground.
- Frame it as "GNOME/KDE get the desktop toggle for free; tiling-WM users on DankMaterialShell can get
  an equivalent via Shazzaam's Dank ASUS Control Center." One `:::info` + link each, no walkthrough.

## File & placement
`docs/guides/asusctl.md` — auto-lists on the `/guides/` index (no `navbar.ts` edit needed, same as the
GPU guide — verify on build). Tags (≤4): `Intermediate` / `asusctl` / `Power` / `Laptop`.

## Outline (guideline entry order: link → `:::info` → `:::tip` → image last; tab order Fedora → Debian/Ubuntu → Arch)
1. Frontmatter + intro `:::info` — what the guide covers; ASUS ROG/TUF only; meet `asusctl` + ROG
   Control Center.
2. `## Installing asusctl` — `:::tabs` Fedora / Debian/Ubuntu / Arch per commands above; enable
   `asusd.service`; the ppd swap/coexistence note as `:::warning`.
3. `## Platform Profiles (Throttle Policy)` — plain-words explainer (Quiet/Balanced/Performance), the
   `/sys/.../platform_profile` node, GUI dropdown + `asusctl profile -p/-n`. Beginner analogy for
   "profile = overall power mode".
4. `## Energy Performance Preference (EPP)` — what it is in plain words, the **linked EPP** toggle, the
   per-profile EPP dropdowns. Deep "why/sysfs" detail inside `::::details`.
5. `## Automate: performance on AC, power-saving on battery` — the payoff section. GUI steps for
   "Throttle Policy for power state" (enable AC→Performance, Battery→Quiet, linked-EPP ON). Screenshot
   last.
6. `## Verify it's working` — the sysfs/`asusctl`/`journalctl` checks + the unplug/replug live test.
7. `## Power profiles vs. your desktop's toggle` — short: Quick-Settings toggle vs asusctl, the shared
   sysfs node, run one owner. (This is the ppd gotcha, kept beginner-level.)
8. `## Tiling window managers` — the incredibly-brief Dank/ASUS Control plugin mention.

## Assets — TEXT-FIRST
Ship with no images. Leave image slots (last per entry order) as `<!-- TODO image: … -->` markers,
chiefly the ROG Control Center **System tab** shot (EPP-link + AC/battery toggles). When captured,
drop into `docs/.vuepress/public/assets/asusctl/` and reference root-relative as `/assets/asusctl/<name>.png`.
Image backfill is tracked in ROADMAP **Deferred** (same item flags `gnome-further-customisation.md`).

## Steps
1. Read `guidelines.md` conventions (done for this plan; re-skim entry order + colon nesting at write).
2. Write `docs/guides/asusctl.md` per outline — beginner/GUI-first, text-only, TODO image markers.
3. Production build; confirm 0 dead links + guide auto-listed on `/guides/`.
4. Update `ROADMAP.md` (move build item to Completed; leave the image-backfill item in Deferred).

## Out of scope
Aura RGB / AniMe Matrix LED control; fan-curve editing; `supergfxctl`/GPU switching (covered by the
GPU/Cardwire guide — cross-link instead); a downloadable zip bundle (no dotfiles — GUI + inline CLI only).

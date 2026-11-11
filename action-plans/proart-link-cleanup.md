# ProArt + cross-repo link cleanup

**Goal** — every task is documented in one place. Readers follow links one way, from where they start to where the detail lives, and never bounce back.

**Scope** — `tuxies-wiki`, `DankAsusControl` (DAC), `hypr-dms`. Wording only; no code changes.

## Current link map

```
aiers-fedora ──► hypr-dms ──► DAC ──► proart-p16 ──► DAC (x2), proart-key/
     ▲              │          │           │
     └──────────────┘          │           └──► gpu, asusctl
       (Gaze link)             └──► asusctl (prereq)
```

Problems:

1. **ProArt button is split across two places.** `proart-p16-2025.md` hand-rolls the listener (udev rule, Python script, systemd unit, ~100 lines) and also points at DAC's one-command installer. DAC's README points back to the wiki for other models' keyboard IDs. Too hard for the wiki's beginner audience, and niche (one laptop, one DMS plugin).
2. **aiers-fedora ⇄ hypr-dms.** The wiki hub links the repo, and the repo's "Optional extras" link back to the hub for Gaze, while also sending ASUS users to DAC directly.

## Rules

- **Hub → leaf, plus one "up" link.** The wiki (hub) links out to tools. A tool links back at most once, for a prerequisite it doesn't explain (DAC → asusctl) or as a single "more setup" pointer.
- **No split tasks.** A procedure lives wholly in the wiki or wholly in a repo. The other side gets one link or nothing.
- **Wiki keeps beginner-grade content.** Anything needing a custom script or hardware IDs lives in the tool's repo.

## Steps

| # | Repo | Change | Done when |
|---|---|---|---|
| 1 | tuxies-wiki | Delete `## ProArt Button does nothing` (lines 77–175) from `proart-p16-2025.md`. Page keeps the battery-drain fix and the gpu/asusctl info box. | No `hidraw`, `proart-key` or DAC mention left on the page |
| 2 | DankAsusControl | Make the README's ProArt key section self-contained: move in the "other ASUS models" tip (`grep HID_ID /sys/class/hidraw/*/device/uevent`, pick the `ITE` one, swap `idProduct` + `HID_ID`). Drop the wiki link. | README has no `proart-p16-2025` link; asusctl prereq link stays |
| 3 | tuxies-wiki | ROADMAP: log the change; close the 2026-10-24 ProArt-button and 2026-11-04 tip entries as superseded. | ROADMAP updated |
| 4 | DankAsusControl | ROADMAP: log the change. | ROADMAP updated |

Steps 1–2 ship together so the ProArt key is never undocumented.

## Decisions (2026-11-11)

- The wiki mentions DAC nowhere, to keep it lean. Dropped the planned `aiers-fedora.md` entry.
- hypr-dms keeps its DAC link and its Gaze link to aiers-fedora. No hypr-dms change.

**Status** — done 2026-11-11.

## Out of scope

- `gpu.md` repeats "contributions are very welcome" in four distro tabs. Each tab needs its own note, so it stays.
- `asusctl.md` maintainer review (separate ROADMAP item).
- Removing the ProArt key feature from DAC.

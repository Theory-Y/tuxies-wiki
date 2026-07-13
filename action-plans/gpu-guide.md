# Action Plan — GPU Guide (drivers + Cardwire)

Source: `OVERRIDE.md`. Decisions locked with maintainer (2026-07-13):
Cardwire = real tool (`OpenGamingCollective/cardwire`, supergfxctl successor); **Fedora only**
with a "tested on Fedora, other-distro contributions welcome" note; **AMD + NVIDIA** drivers only;
title **GPU Guide**, permalink `/guides/gpu/`.

## Verified upstream facts (do not invent — all from docs/README/extension page)

- **What it is:** eBPF-LSM GPU manager, successor to the deprecated `supergfxctl`. Blocks a GPU by
  making syscalls to its device node return `-ENOENT`. No reboot/logout to switch.
- **Requirements:** Wayland only (X11 unsupported), systemd only, kernel ≥ 5.7 with
  `CONFIG_BPF_LSM`. BPF-LSM ships pre-enabled on Fedora. Experimental — expect rough edges.
- **Fedora install:** needs Terra repo (already documented in `linux-guides/fedora.md` → cross-link,
  don't re-teach). Then `sudo dnf install cardwire`; enable daemon `sudo systemctl enable cardwired --now`.
- **CLI:** `cardwire get` · `cardwire list` · `cardwire set integrated|hybrid|manual|smart` ·
  `cardwire gpu <id> --block|--unblock|--lsof` (manual mode only).
- **Config CLI:** `cardwire config battery-auto-switch true` ·
  `cardwire config battery-auto-switch-mode integrated|hybrid|manual|smart` ·
  `cardwire config auto-apply-gpu-state true` · `cardwire config experimental-nvidia-block true` ·
  `cardwire config save` (persist). Any config key queried by omitting the value.
  GPU-state store: `/var/lib/cardwire/gpu_state.json`.
- **Modes** (Integrated/Hybrid/Smart need exactly two GPUs):
  - `integrated` — blocks the dGPU (best battery).
  - `hybrid` — unblocks the dGPU (both available).
  - `manual` — default/safe; per-GPU block/unblock.
  - `smart` — like integrated, but eBPF inspects apps at launch and selectively allows GPU access.
- **Config file** `/etc/cardwire/cardwire.toml`: `battery_auto_switch = false`,
  `battery_auto_switch_mode = "hybrid"` (mode used on **AC**; on battery it drops to integrated),
  plus `auto_apply_gpu_state`, `experimental_nvidia_block`.
- **GNOME extension:** "Cardwire GPU Toggle", ext ID **9919**,
  <https://extensions.gnome.org/extension/9919/cardwire-gpu-toggle/> — Quick-Settings toggle
  (Integrated/Hybrid/Manual) via the cardwire D-Bus daemon, dual-GPU laptops, GNOME 45–50.

## OVERRIDE reconciliation

OVERRIDE wrote `cardwire config-battery-auto-switch true` / `config-battery-auto-swtich-mode hybrid`.
Real syntax uses a `config` **subcommand** (space, not hyphen) + correct spelling:
`cardwire config battery-auto-switch true`, `cardwire config battery-auto-switch-mode hybrid`,
`cardwire config save`. Recommended-setup section uses these CLI commands (`:::tabs` apply/reset
pair), matching OVERRIDE intent.

## File

`docs/guides/gpu.md` — title `GPU Guide`, permalink `/guides/gpu/`, tags Intermediate / GPU / Cardwire.
Auto-lists on the `/guides/` index (no navbar edit needed — verify at build).

## Outline (guideline entry order: link → :::info → :::tip → image last)

1. Frontmatter + intro `:::info` (what the guide covers; meet **Cardwire**).
2. `:::warning` Fedora-tested-only note + contributions welcome.
3. `::::details Quick append` — recommended `cardwire config …` command set via `:::tabs`.
4. `## Installing drivers` — `## **Identifying your GPU**` (`lspci | grep -E 'VGA|3D'`), then
   `:::tabs` AMD (mesa preinstalled, nothing to do) / NVIDIA (RPM Fusion + `akmod-nvidia`, reboot).
5. `## Cardwire` — requirements `:::warning` (Wayland), install steps (Terra cross-link + dnf +
   enable `cardwired`), `### Basic commands` (get/list/set + mode table), `### Recommended setup`
   (`cardwire config battery-auto-switch …` + `cardwire config save`).
6. `## Gnome Extension: Cardwire GPU Toggle` — link → `:::info` → screenshot last.

## Assets

Move `Cardwire GPU toggle.png` → `docs/.vuepress/public/assets/gpu/cardwire-gpu-toggle.png`.
Reference as `/assets/gpu/cardwire-gpu-toggle.png`.

## Steps

1. Move + rename image asset.
2. Write `docs/guides/gpu.md` per outline (read `guidelines.md` conventions first — done).
3. Production build; confirm 0 dead links + guide auto-listed on `/guides/`.
4. Update `ROADMAP.md` (Completed), delete `OVERRIDE.md`.

## Out of scope

Intel iGPU section; Debian/Arch tabs; a downloadable zip bundle (single config, shown inline).

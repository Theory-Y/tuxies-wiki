# Roadmap

Active and planned work for the wiki. Resolved audit history is collapsed at the
bottom — see **Completed** for the record.

Legend: 🔴 dangerous / data-loss · 🟠 broken command · 🟡 missing step / gap · 🔵 style

---

## Open

_Nothing open — all tracked work is complete or parked in **Deferred** below._

---

## Deferred

- 🟡 **MosaicWM extension** (ext 8502, `CleoMenezesJr/MosaicWM`) — mosaic/tiling WM for GNOME.
  Currently **unstable** and needs GNOME Shell 50+; do **not** add to
  `gnome-further-customisation.md` yet. **Re-evaluate stability from 2026-10-16 for a week
  straight** — if stable by then, add it under the **Others** collapse (Tiling Shell neighbour)
  with the standard link → `:::info` entry.

---

## Completed

- **OVERRIDE.md batch — extension stars · Lilypad · Dash-to-Dock shortcut · MosaicWM defer (2026-07-16)** —
  five override items cleared in `docs/guides/gnome-further-customisation.md`; `OVERRIDE.md` deleted.
  - **Unstarred** four entries (removed 🌟): Battery Health Charging, Shotzy, Night Theme Switcher,
    Focus changer.
  - **Lilypad added** (ext 7266, `shendrew/Lilypad`) — top-bar icon organiser, placed directly after
    AppIndicator in the **Universal benefits** collapse as a complementary suggestion
    (`_(pairs well with AppIndicator)_`), single `:::info`, unstarred, no config.
  - **Dash to Dock shortcut** — added a `:::tip Fix the keyboard shortcut` block: the extension's
    default show-dock bind is `['<Super>q']`, which now collides with the Close window shortcut
    (`Super`+`Q`, commit 38327f8); moved to `<Super>w` via
    `dconf write /org/gnome/shell/extensions/dash-to-dock/shortcut "['<Super>w']"`.
  - **MosaicWM** parked in **Deferred** above (unstable, GNOME 50+) with a 2026-10-16 re-eval note —
    not added to the guide.
- **Stage Manager extension (2026-07-16)** — added (ext 9528, `itsdigvijaysing/gnome-stage-manager`)
  in the **Others** collapse right after Dash to Dock, tagged `_(alternative to Dash to Dock)_`. macOS-style
  window grouping; `:::tip` quick-config hides the app dash via Just Perfection
  (`dconf write /org/gnome/shell/extensions/just-perfection/dash false`) since Stage Manager lives on the
  left edge. Build passes (44 pages).

- **GPU Guide — `experimental-nvidia-block` (2026-07-14)** — added NVIDIA-scoped H3 in
  `docs/guides/gpu.md` after Recommended setup: `cardwire config experimental-nvidia-block true`
  blocks shared Nvidia device files (`/dev/nvidiactl`) to stop unwanted dGPU wakeups from Vulkan/GNOME
  apps and `nvtop`, cutting battery drain; `:::warning` notes the exactly-two-chips + experimental
  caveat. Also wired into the Quick append Apply/Reset tabs. `auto-apply-gpu-state` evaluated and
  skipped — niche manual-mode convenience that contradicts the guide's `battery-auto-switch` path.
- **GPU Guide — drivers + Cardwire (2026-07-13)** — new `docs/guides/gpu.md` (title `GPU Guide`,
  permalink `/guides/gpu/`, tags Intermediate/GPU/Cardwire), auto-listed on `/guides/`. Covers:
  identifying the GPU (`lspci`), AMD (Mesa preinstalled, no-op) vs NVIDIA (RPM Fusion + `akmod-nvidia`,
  module-build wait, reboot) in `::::tabs` with `simple-icons` AMD/NVIDIA marks; then **Cardwire**
  (`OpenGamingCollective/cardwire`, the eBPF-LSM `supergfxctl` successor) — Wayland/experimental
  warning, Terra-repo install cross-linked to `fedora.md`, `cardwire list/get/set` + mode table
  (integrated/hybrid/manual/smart), manual `gpu <id> --block/--unblock/--lsof`, and battery
  auto-switch via `cardwire config battery-auto-switch[-mode] … && cardwire config save`; closes with
  the **Cardwire GPU Toggle** GNOME extension (ext 9919). All commands/modes/requirements verified
  against upstream docs — the OVERRIDE's `config-battery-auto-switch` guesswork was reconciled to the
  real `config battery-auto-switch` subcommand syntax. Fedora-only (warned up top, other-distro
  contributions invited). Image `Cardwire GPU toggle.png` → `assets/gpu/cardwire-gpu-toggle.png`.
  plan: `action-plans/gpu-guide.md`. Production build passes (44 pages, no dead links); `OVERRIDE.md`
  deleted.
- **Same-origin downloads + guide-canonical source of truth (2026-07-13)** — routed all guide
  download links through `/assets/*.zip` (no GitHub detour); zipped extensionless/`.jsonc` files
  that 404'd under the SPA router or rendered as inline text; dropped the redundant `yazi` mirror.
  Then set the **guide** as canonical: scanned every `resources/` file for a guide-inline copy and
  reconciled the only two divergences found — the `keyd` config comment (`Ctrl; ` → `Ctrl, `, now
  identical across guide, `resources/default.conf`, and the `keyd-setup.sh` heredoc) and a stale
  `README.md` inside the pre-existing `logitech-linux-setup.zip` (rebuilt from `resources/`). Both
  bundle zips regenerated and verified byte-identical to their `resources/` source. Policy recorded
  in `guidelines.md` → Download bundles. (Supersedes the earlier keyd triple-copy drift item.)
  plan: `action-plans/override-2026-07-12.md`; player-coach (council skipped per maintainer).
  Production build passes (43 pages, no dead links); `OVERRIDE.md` deleted.
  - **NVIDIA driver link** — `fedora.md` install-resources list: `NVIDIA Drivers Guide`
    (rpmfusion.org/Howto/NVIDIA) → `NVIDIA GPU Driver Installation`
    (docs.fedoraproject.org/en-US/gaming/drivers/), attribution changed to "the Fedora Docs".
  - **Popular → standalone Discord/Vesktop guide** — `linux-apps/popular.md` (Discord-only content)
    moved verbatim to `docs/guides/discord-vesktop.md` (title `Discord & Vesktop`, permalink
    `/guides/discord-vesktop/`, tags Beginner/Apps, contributors aier+Lunear); auto-listed on the
    `/guides/` index. Removed from the app series: navbar `Popular` item, `linux-apps/README.md`
    card, and the category list in `new-to-the-wiki.md` (`Popular` → `Creative Software`, which the
    list had been missing). 0 residual `/linux-apps/popular/` refs repo-wide.
  - **Extensions (gnome-further-customisation.md)** — added **Battery Health Charging** (ext 5724)
    in alphabetical slot after Auto Power Profile, using the pre-committed unused asset
    `battery-health-limit-demonstration.png`. **Copyous** entry gained a dependency-install block
    (`::::tip` > `:::tabs`) for Libgda-with-SQLite + GSound, verified from upstream README:
    Fedora `libgda libgda-sqlite`, Arch `libgda6`, Ubuntu/Debian `gir1.2-gda-5.0 gir1.2-gsound-1.0`,
    openSUSE `libgda-6_0-sqlite typelib-1_0-Gda-6_0 typelib-1_0-GSound-1_0` (openSUSE tab uses the
    `::devicon:linux::` fallback — no opensuse devicon in the repo). Auto Power Profile was already
    present (prior session) — left untouched, not duplicated. `graphify update` not run (CLI absent).
- **OVERRIDE.md batch — colour fix · GB-English sweep · Terra · guide rename (2026-07-12)** —
  four override items cleared (smallest → largest); `OVERRIDE.md` deleted.
  - **Bash guide master quick append — blue PS1** — the master quick append and the PS1 step
    (`terminal-customisation-bash.md` lines 37 + 219) used the purple `setaf 56/92/128/200`
    gradient while their screenshots (`custom-ps1.png`, `aesthetic-terminal.png`) are blue; both
    code blocks swapped to the blue `setaf 26/32/38/44/75` gradient (matching the preview at line
    147), so code now matches the images — no reshoot needed.
  - **GB-English sweep** — repo-wide `-ize`/`-or` audit; 8 prose fixes (`customising`,
    `specialises`, `analyse`, `unauthorised`, `virtualisation`, `modelling`, `flavours`,
    `favourite`) across terminal-customisation-bash, rb-14-2023-fedora, ctf-second-brain,
    qemu-kvm (archived), creative-software, firefox-userjs, linux-apps/README. Code/keywords left
    American on purpose: gsettings `color-scheme`/`control-center`/`minimize,maximize`, `Mission
    Center` (app name), the pacman `synchronize` error string, the `customize` URL, the `"license"`
    package.json field, the `visualization` code path.
  - **Terra added** — new **Terra repository** section in `fedora.md` (enable one-liner,
    web+`gh`-verified: `dnf install --nogpgcheck --repofrompath 'terra,…$releasever' terra-release`).
    Vesktop entry in `popular.md` gained two install tabs on top of the Flatpaks: **Fedora (Terra)**
    `dnf install vesktop` (package name confirmed from the Terra `vesktop.spec`) linking the Terra
    section, and **Arch (AUR)** `yay -S vesktop-bin` (AUR link verified).
  - **aiers-gnome → gnome-further-customisation** — `git mv` of the guide + its asset folder
    (`/assets/aiers-gnome/` → `/assets/gnome-further-customisation/`, 18 files, 12 inline refs);
    title `aier's Gnome (In-Depth Customisations)` → `Further Gnome Customisation`; permalink,
    the gnome.md inbound card link, and the self-reference in the "More resources" list all
    repointed (0 residual refs repo-wide). Added the **Auto Power Profile** extension entry
    (extension 6583, alphabetical slot after AppIndicator). Build-based dead-link check not run
    (`node_modules` absent offline); internal link targets verified by hand. `graphify update` not
    run — CLI unavailable.
- **Older history (through 2026-07-04), compressed** —
  - dconf → gsettings sweep completed repo-wide (gnome.md, aiers-gnome.md, better-text-rendering,
    guidelines.md), with extension-schema commands ultimately reverted to `dconf write` after
    discovering user-installed extensions keep schemas outside `gsettings`' search path.
  - App-lists restructured: new `dev-tools.md` series (fastfetch/fzf/zoxide/eza/Yazi/Fresh/
    Waydroid/SaveDesktop), `gnomie.md` removed (fully covered by `gnome.md`), OBS Studio moved
    into `creative-software.md`.
  - Ghostty guide overhauled: install tabs added, keybind cheatsheet reconciled, GNOME
    workspace-switch conflict resolved (Settings walkthrough dropped — hidden by GNOME's own
    gschema — replaced with a verified `gsettings set ... "[]"` fix).
  - keyd guide: internal-keyboard quirk verified working; libinput CLI verify steps replaced with
    an empirical typing test; new keymap (Copilot→Ctrl, CapsLock→Backspace, Shift+CapsLock→CapsLock)
    propagated to guide + `keyd-setup.sh`.
  - Logitech setup: Wayland `/dev/uinput` permission fix documented, `install.sh` rewritten
    interactive, beginner README rewritten, download migrated to the new same-origin zip
    convention (`/assets/<name>/<name>.zip`, codified in `guidelines.md`).
  - Cloudflare Pages contributors/changelog regression fixed (shallow-clone `git fetch --unshallow`)
    and redeployed with the correct build command.
  - Terminal Customisation (Bash), Yazi, and Firefox `user.js` each got master quick-append /
    cleanup passes; TheoryY fastfetch branding override resolved.
  - Extension/module entry format standardised wiki-wide (link → `:::info` → `:::tip` → image last),
    codified in `guidelines.md`.
  - Two full guide-malpractice audit passes closed out assorted 🔴/🟠/🟡/🔵 fixes across most guides.
  - aier's Gnome page got a "More resources" hub linking the Fedora checklist; fedora.md snapper
    section gained a beginner-friendly explainer.

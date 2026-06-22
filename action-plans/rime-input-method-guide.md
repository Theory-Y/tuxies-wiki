# Action Plan — Rime Input Method guide

**Status:** PLANNED (approved scope: distro-general; awaiting execution)
**Deliverable:** One new wiki guide, `docs/guides/rime-input-method.md`, documenting how to set up
the Rime input method (`ibus-rime`) with Chinese Pinyin (`luna_pinyin`) and Cantonese Jyutping
(`jyut6ping3`) schemas, written to house style and render/command verified.
**Scope decision (locked):** distro-general (Fedora/Debian/Arch tabs). **No NixOS section** — the
content originated from a NixOS config (`aierNix`) but the wiki audience is general Linux.

## 0. Pre-flight (verify before writing)
- Re-read `CLAUDE.md` + `docs/notes/about/contributions/guidelines.md` at execution time.
- **[CRITICAL — hard pre-publish gate] Verify every install command before publishing.** Only
  Fedora's `ibus-rime` → `librime` + `brise` is web-verified. Debian (`apt`, `rime-data-*` split)
  and Arch (`pacman`, `rime-cantonese`) package names are **UNVERIFIED** — confirm exact names
  against packages.debian.org / archlinux.org+AUR before the page goes live. A public guide with
  a broken install line is the primary failure mode.

## 1. File & placement
- Path: `docs/guides/rime-input-method.md` (kebab-case; auto-discovered under "Other Guides" — no
  navbar/config edit needed).
- Frontmatter (title case; max 4 tags; GB English; set `createTime` at write time):
  ```yaml
  ---
  title: Rime Input Method Setup
  tags:
    - Beginner
    - Rime
    - Input-Method
    - Productivity
  createTime: YYYY/MM/DD HH:MM:SS
  permalink: /guides/rime-input-method/
  contributors:
    - aier9500
  ---
  ```
  - ⚠ Confirm the **tag taxonomy** against `guidelines.md` — `Input-Method` must be a sanctioned
    category; if not, use an existing category tag (e.g. `Productivity`) and trim to ≤4 tags.

## 2. Content outline (mirror `docs/guides/ghostty-terminal.md`)
1. `:::info` intro — what Rime is; what this guide sets up (Pinyin + Cantonese Jyutping via
   `ibus-rime` under GNOME); prerequisites (GNOME/IBus).
2. `::::details Quick append` → `:::code-tabs` with the full
   `~/.config/ibus/rime/default.custom.yaml` for copy-paste.
3. **Installation** — `:::tabs` Fedora → Debian/Ubuntu → Arch (devicon icons):
   - Fedora: `sudo dnf install ibus-rime` (auto-pulls `librime` + `brise` schema data). ✅ verified.
   - Debian/Ubuntu: `sudo apt install ibus-rime` (+ note Debian splits schemas into `rime-data-*`;
     may need `rime-data-jyut6ping3`, `rime-data-luna-pinyin`). ⚠ verify names.
   - Arch: `sudo pacman -S ibus-rime` (+ AUR / `rime-cantonese` for Jyutping). ⚠ verify names.
   - **Inline the `jyut6ping3` availability check here**, right after install
     (`rpm -ql brise | grep jyut6ping3` on Fedora / check the Debian `rime-data-jyut6ping3` pkg /
     Arch `rime-cantonese`), so a missing schema is caught before the reader tries to enable it.
4. **Enabling the schemas** — the `default.custom.yaml` step. Be honest that this part is a
   text-file edit, not GUI; show the `schema_list` patch; explain `patch:` overrides rather than
   extends. Mention editing via a GUI editor (e.g. `gnome-text-editor`) so it's not framed as
   terminal-only.
5. **Deploying** — IBus/Rime tray → **Deploy** (GUI) or log out/in; Rime builds into
   `~/.config/ibus/rime/build/`.
6. **Adding the GNOME input source** — Settings → Keyboard → Input Sources → + → Chinese → Rime
   (GUI), with the `gsettings` one-liner as the CLI alternative.
7. **Switching** — `Super`+`Space` between sources; `F4` / `Ctrl`+`` ` `` between Pinyin and
   Cantonese inside Rime (wiki keybinding format: each key backticked, joined with `+`).
8. `:::warning` **Cantonese fallback** — if §3's check showed `jyut6ping3` is absent: it lives in
   a separate upstream repo (`rime/rime-cantonese`); drop the schema files into
   `~/.config/ibus/rime/` and redeploy.
9. **Resources** — rime.im, `rime/ibus-rime`, `rime/rime-cantonese`, ArchWiki Rime.

## 3. House-style checklist
- Backtick all programs/paths/files (`rime`, `ibus`, `~/.config/ibus/rime/`).
- `==highlight==` for prose emphasis, not bold.
- H2 in title case with bold keywords; callouts `:::info` / `:::tip` / `:::warning` / `:::danger`.
- Distro tabs in Fedora → Debian → Arch order with devicon icons.
- Container nesting: innermost 3 colons, +1 per outer level.
- GB English; "we" voice; concise/professional.

## 4. Validation (two distinct checks — don't conflate)
- **Render check:** `npm run build` (or `npm run dev` to preview) confirms containers/tabs PARSE.
- **Correctness check:** separately verify install commands / package names / schema IDs against
  distro package sources (the CRITICAL gate above). This is the check that matters for a public page.
- If the `graphify` CLI is available, `graphify update .` after writing (it has been unavailable in
  recent sessions — skip with a note if so).

## 5. Suggested delegation (lean — one-page task)
- **Authoring** → one `sonnet-task-executor-high`: curated brief = this outline + verbatim style
  rules + the source config + Fedora-verified facts (Debian/Arch flagged "verify").
- **One independent fact-check** → a second agent verifies Debian/Arch package names + the
  `jyut6ping3` availability claim, then render-checks the build.

## Source material (content reference, from the aierNix repo)
- `modules/system/ibus.nix` — `i18n.inputMethod` registers `ibus-engines.rime`.
- `modules/home/misc/ibus-rime.nix` — writes `default.custom.yaml` enabling `luna_pinyin` +
  `jyut6ping3`.
- `modules/home/theming/gnome-dconf/gnome-input-sources.nix` — adds `('ibus','rime')` to GNOME
  input sources.

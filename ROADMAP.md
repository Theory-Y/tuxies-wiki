# Roadmap

Active and planned work for the wiki. Resolved audit history is collapsed at the
bottom — see **Completed** for the record.

Legend: 🔴 dangerous / data-loss · 🟠 broken command · 🟡 missing step / gap · 🔵 style

---

## Open

### Cloudflare Pages — contributors/changelog redeploy

- [ ] 🟡 Set the Cloudflare Pages project **Build command** to `npm run build-cf`, then
      redeploy. The `git fetch --unshallow` fix is already in `package.json`; it only takes
      effect once CF uses `build-cf`. Cannot be done from the repo (dashboard setting).
      After deploy, verify a multi-author page (e.g. `/guides/ssh-guide/`) shows multiple
      contributors and a full changelog again. (Regression diagnosed 2026-06-05.)

### keyd guide — internal-keyboard quirk file permissions

**Files:** `resources/key-remapping-with-keyd/keyd-setup.sh`, `docs/guides/key-remapping-with-keyd.md`

- [x] Fixed the setup script's quirks write: it used `mktemp` + `cp`, leaving
      `/etc/libinput/local-overrides.quirks` mode `600` (root-only). `libinput` parses quirks
      from the user-level compositor, so a root-only file is silently ignored and keyd was
      never registered as internal — right place, right content, never applied. Changed the
      copy to `install -m 644`. Added a **Verifying the registration** subsection to the guide
      (no libinput "reload" — reboot or restart keyd re-reads quirks; confirm with
      `sudo libinput quirks list /dev/input/eventXX`; world-readable `644` warning).
- [x] **Quirk load confirmed (Fedora 44 / GNOME Wayland, 2026-06-22):** with the file at `644`
      and `libinput-utils` installed, `sudo libinput quirks list` on keyd's virtual keyboard
      reports `AttrKeyboardIntegration=internal`. Confirms the permissions root cause — a
      readable file makes the quirk apply, so the `install -m 644` script fix is correct.
- [ ] 🟡 **Effect not yet verified** — the behavioural payoff (palm rejection /
      disable-while-typing pairing with the touchpad) needs a re-login to take effect; not yet
      tested (expected to work). Confirm before publish. Guide is tagged `Testing-Needed`.
- [ ] 🟡 The `libinput quirks` subcommand is **not** in the base `libinput` package — it ships
      with the debug utilities (Fedora: `libinput-utils`, verified). The guide's verify step now
      notes the Fedora package. **Before publish, confirm the equivalent package name on
      Debian/Ubuntu and Arch** (Debian is likely `libinput-tools`; Arch likely bundles it in
      `libinput` — both unconfirmed) and decide whether the verify step needs distro tabs.

### fedora.md — snapper / systemd image fix

**File:** `docs/notes/linux-guides/fedora.md`

- [ ] 🟡 Document the **snapper systemd img fix**. Scope to be fleshed out — recorded as
      requested 2026-06-21; confirm exact symptom/commands before writing.

### Logitech guide — beginner-friendly README & install flow

**Files:** `resources/logitech-linux-setup/README.md`, `docs/guides/logitech-linux-setup.md`

- [ ] 🟡 Rewrite the README to be more beginner-friendly.
- [ ] 🟡 Offer a **zip** of the `resources/logitech-linux-setup` folder so users can grab it
      from GitHub and install without cloning the whole repo.
- [ ] 🟡 Tell users in the guide to have `Solaar` and `Kando` installed **before** running the
      dotfile install script.
- _Progress (2026-06-22):_ `install.sh` is now highly interactive (inspect + `nano`-edit each
  dotfile, per-phase `[y/n]` gates, opt-in disclosed `sudo` uinput phase) and warns when neither
  a Flatpak nor native install of an app is detected; its `README.md` was updated to match. Still
  open here: the **beginner-friendly README rewrite**, the **zip** download, and the guide's
  explicit "install `Solaar`/`Kando` first" note.

### Rime input method — new guide

**File:** `docs/guides/rime-input-method.md` (new) · **Plan:** `action-plans/rime-input-method-guide.md`

- [ ] 🟡 Write a distro-general guide for the **Rime** input method (`ibus-rime`) covering Chinese
      Pinyin (`luna_pinyin`) and Cantonese Jyutping (`jyut6ping3`): install (Fedora/Debian/Arch
      tabs), enabling schemas via `~/.config/ibus/rime/default.custom.yaml`, deploying, adding the
      GNOME input source, and switching (`Super`+`Space` / `F4`). Mirror the `ghostty-terminal.md`
      structure. **Pre-publish gate:** only Fedora's `ibus-rime`→`librime`+`brise` is verified —
      confirm Debian (`rime-data-*`) and Arch (`rime-cantonese`) package names before publish, and
      inline the `jyut6ping3` availability check in the Installation step. No NixOS section (scope
      locked distro-general). Full outline in the linked action plan. (Captured 2026-06-21 from a
      live ibus-rime setup on the aierNix repo.)

### Download bundles — host on the wiki for same-origin downloads

**Files:** `docs/guides/logitech-linux-setup.md`, `docs/notes/about/contributions/guidelines.md`,
future download-offering guides · **Convention change**

- [ ] 🔵 Change the download-bundle convention so a guide's "download the zip" link is served
      **same-origin from the wiki** (click → download, no trip to GitHub). Mechanism: place the bundle at
      `docs/.vuepress/public/assets/<name>/<name>.zip` and link `/assets/<name>/<name>.zip` — confirmed
      served at the site root (`base: "/"`; the guides' own `/assets/...` images already prove it). The
      current convention links the GitHub `raw` URL of `resources/<name>/` instead (works, but bounces the
      reader out to github.com).
      - **Open decision — keeping the hosted zip in sync with `resources/<name>/`:** (a) committed static
        zip in `public/assets/` (simple; must be manually re-zipped whenever the folder changes), or (b)
        generate it at build time (zip `resources/<name>/` into `public/assets/` in the `build`/`build-cf`
        script — always current, but edits the build pipeline, still fragile from the open CF `build-cf`
        regression above). Decide (a) vs (b) before migrating.
      - **Migrate** the Logitech guide's zip link (currently GitHub `raw`) to the new convention, then
        **codify** it in `guidelines.md` so future download offers follow suit.

---

## Completed

- **fedora.md — stale footer link removed (2026-06-22)** — dropped the `aier's Gnome` link from
  the **Further customisation** footer of `fedora.md`; the target page persists and stays reachable
  via `gnome.md`.
- **Terminal Customisation (Bash) — master quick append (2026-06-22)** — added one unified
  `::::details Master quick append` after the intro consolidating all six `.bashrc` snippets
  (`fastfetch` autorun, `PS1`, `fzf` aliases, `zoxide` init, the `eza` alias set, and the `yazi`
  `y()` cd-on-exit wrapper), each copied verbatim from its canonical instruction site (the canonical
  `PS1` from the instruction step, not the divergent preview); the two per-section quick-appends left
  intact.
- **Firefox `user.js` — touchpad scrolling demoted, publish hold lifted (2026-06-22)** — the
  2026-06-10 edits are cleared for deploy after review: three touchpad-specific
  `apz.gtk.pangesture.*` / `apz.overscroll` prefs commented out as an optional choice,
  `apz.fling_friction` retuned `"0.005"`→`"0.004"`, and a `:::tip` added pointing to the
  system-level touchpad fix on `/guides/external-resources/`. No in-file flag existed — the
  hold lived only here in the roadmap.
- **Logitech setup — guide + installer overhaul (2026-06-22)** — documented the Wayland
  `/dev/uinput` permission fix (persistent `/etc/udev/rules.d/60-uinput.rules` + `input` group +
  re-login; `setfacl` one-shot alternative), with the mechanism tucked into a `::::details` so
  newcomers see symptom→fix only. Fixed the guide's mic-mute keysym
  (`XF86AudioMicMute`→`XF86_AudioMicMute`, matching the working `rules.yaml`) and now document
  **all** preset remaps transparently (5 MX Keys S F-row keys + 7 MX Master 4 buttons: Back=hold
  `Ctrl`, Forward=hold `Shift`, Mouse-Gesture=hold `Super`, Haptic=`Super`+`Shift`+`F1` Kando
  trigger). Rewrote `install.sh` into a highly-interactive installer (keyd-setup.sh style):
  inspect + `nano`-edit each dotfile before install, per-phase `[y/n]` gates, and an **opt-in,
  fully-disclosed** `sudo` uinput phase (skipped under `-y`/non-TTY). Stripped the stray
  `windowsInkWorkaround` from the Kando preset; updated the folder `README.md`. **Test caveat:**
  the uinput phase ran cleanly after a re-login (2026-06-22) and remaps fire — but the test
  device's remaps already worked beforehand, so this confirms the script runs without error, not
  that the uinput fix is what enables them; most likely correct/cleared, though a clean
  confirmation needs a device where remaps were broken first. `graphify update` not run — CLI
  unavailable.
- **Ghostty guide overhaul (2026-06-22)** — added install `:::tabs` (Fedora COPR ·
  Debian/Ubuntu = the community Ubuntu installer + Debian-incompat note + official-guide link ·
  Arch `pacman`; commands web-verified). Removed `Everforest` from the quick-append (theme-less).
  Reconciled the cheatsheet against `ghostty +list-keybinds`: dropped the macOS-only "Equalize
  splits", added Select all / Start search / Toggle command palette (macOS command-palette cell
  left a flagged `[unconfirmed]` placeholder). Fixed focus-split: GNOME grabs
  `Ctrl`+`Alt`+`Up`/`Down` (workspace switch), so added a "For GNOME users" config rebinding all
  four `goto_split` directions to `alt`+`shift`+arrow. Split the quick-append into two complete
  master blocks (normal + GNOME). `graphify update` not run — CLI unavailable.
- **Yazi neutral reskin + master quick append (2026-06-22)** — de-Everforested the `[which]`
  popup to neutral greys (`#1e2228` bg, `#8a8f98`/`#c5c8d0`/`#6b7280`, kept the gold `cand`
  accent) in both `theme.toml` copies; added a master quick append consolidating all four
  config/command snippets. `graphify update` not run — CLI unavailable.
- **Guideline — hide technical detail in collapse (2026-06-22)** — codified in `guidelines.md`
  (**Details & collapse**): tuck deep "why"/internals into `::::details` so newcomers follow the
  actionable steps without being overwhelmed; keep symptom + fix in the main flow.
- **TheoryY fastfetch override resolved (2026-06-22)** — branded `config.jsonc` created and
  linked from the terminal-customisation guide, and the guide screenshot refreshed to the branded
  render; `OVERRIDE.md` cleared.
- **Extension/module entry format standardised (2026-06-20)** — defined a fixed display
  order for extension/app entries in collapse modules: `link _(notes)_` → `:::info`
  description → `:::tip` config → picture/video **last**, so links and configs always sit
  above the demonstration (readers were missing custom configs that tall screenshots pushed
  below the fold). Reformatted both collapse sections of `docs/guides/aiers-gnome.md`
  (dropped the stray per-item `card` on AppIndicator; moved configs above images for Just
  Perfection, Alphabetical App Grid, Dash to Dock, Show Desktop Plus; normalised
  `::: info`→`:::info` and `My settings:`→`My settings`; wrapped the Show Desktop Plus video
  in `:::demo-wrapper`). Codified it in a new **Extension & module entries** section of
  `docs/notes/about/contributions/guidelines.md` (+ a pointer from **Details & collapse**).
  Other guides (`logitech-linux-setup`, `terminal-customisation-bash`, `firefox-userjs`,
  `ghostty-terminal`, `yazi`) audited — already compliant (configs precede screenshots within
  their steps/quick-appends). Also copied `blur-my-shell-demonstration.png` →
  `just-perfection-demonstration.png` (the shot shows both extensions' effects; duplicated
  under the convention name to avoid future confusion) and repointed the Just Perfection
  image. `graphify update .` not run — CLI unavailable in this environment.
- **Logitech setup install script (2026-06-19)** — added
  `resources/logitech-linux-setup/install.sh`: quick-installs the Solaar
  (`rules.yaml`) and Kando (`config.json` + `menus.json`) presets, auto-detecting
  Flatpak vs native config paths (`--flatpak`/`--native` to force), timestamped
  backups before overwrite, idempotent (skips unchanged files), and warns to quit
  Solaar first (it rewrites `rules.yaml`; Kando hot-reloads). Created the folder's
  first `README.md`, and added a **Quick append** to
  `docs/guides/logitech-linux-setup.md` pointing readers at the installer.
  `graphify update .` not run — CLI unavailable in this environment.
- **Guide audit (pass 1)** — all guides reviewed for malpractice; 🔴/🟠/🟡/🔵 fixes landed
  across `editors-choice.md`, `terminal-customisation-bash.md`, `rb-14-2023-fedora.md`,
  `ssh-guide.md`, `key-remapping-with-keyd.md`, `microsoft-edge-setup.md`, and the
  error-dense `arch.md`. `graphify update .` run after landing.
- **Guide audit (pass 2, 2026-06-04)** — full re-read incl. `notes/`. Fixes in
  `rb-14-2023-fedora.md` (`/usr/bin/` → `/usr/local/bin/`), `editors-choice.md`
  (Bitwarden links/description, Inkscape/Vesktop syntax), `arch.md` (missing `sudo`),
  `vuepress-guide.md`, `qemu-kvm.md`, `ssh-guide.md` (Ed25519, `ssh-copy-id -i`),
  `aiers-gnome.md`, `ctf-second-brain.md`, `terminal-customisation-bash.md`.
  `graphify update .` run after.
- **Contributors/changelog regression (2026-06-05)** — root-caused to Cloudflare Pages
  shallow clone (depth 1) collapsing git-derived metadata to one commit. Fix: prepend
  `git fetch --unshallow 2>/dev/null || true` to `build` / `build-cf` scripts. Repo side
  done; deploy side tracked under **Open** above.
- **aier's Gnome → checklist hub (2026-06-19)** — appended a "More resources..." `:::info`
  callout at the bottom of `aiers-gnome.md` linking every item on aier's Fedora checklist
  (`docs/.vuepress/public/reference-docs/aiers-fedora-checklist.md`), grouped as on the
  checklist. "Pre-partition for dual boot" → Fedora guide (no dedicated partitioning page);
  "Fluent icons & cursor" omitted — no coverage anywhere in the wiki (candidate to also
  remove from the checklist source). `graphify update .` could **not** be run — the
  `graphify` CLI is unavailable in this environment; run it where installed to refresh
  `graphify-out/`.

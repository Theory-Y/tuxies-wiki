# Roadmap

Active and planned work for the wiki. Resolved audit history is collapsed at the
bottom — see **Completed** for the record.

Legend: 🔴 dangerous / data-loss · 🟠 broken command · 🟡 missing step / gap · 🔵 style

---

## Open

_Nothing open — all tracked work is complete or parked in **Deferred** below._

---

---

## Completed

- **aiers-gnome.md — extension commands reverted to dconf; schema question resolved (2026-07-04)** —
  the extension-schema verify item closed with a twist. Schema IDs from the conversion were
  CORRECT (confirmed from the installed extensions' own `gschema.xml`: copyous, just-perfection,
  nightthemeswitcher.commands), but the converted commands fail anyway: user-installed extensions
  keep schemas inside their extension folder, which plain `gsettings` does not search
  (`No such schema` — reproduced live; only `--schemadir <ext>/schemas/` works). `dconf write`
  is schema-less, which is why the originals worked. Resolution: extension settings reverted to
  the original `dconf write` lines (also covers the never-verifiable uninstalled aztaskbar /
  show-desktop-plus / clipboard-indicator); core-schema commands stay `gsettings`
  (`org.gnome.shell.keybindings` visibility verified). nightthemeswitcher sunrise/sunset kept
  zero-escape: outer `dconf write "'...'"`, inner plain `gsettings ... prefer-light`. A `:::note`
  in the guide's Extensions section explains the split; the guidelines.md "My settings" example
  swapped to a `dconf write` model so contributors don't copy the broken pattern.
- **App-lists restructure + dconf→gsettings sweep (2026-07-04)** — closes the two OVERRIDE-era
  items ("revise the app lists", "slim down app series"); plan:
  `action-plans/app-lists-restructure-2026-07-04.md`, spec from the maintainer's notepad.md.
  Production build passes (43 pages, no dead links).
  - **New series `dev-tools.md` ("Dev (Computer Nerd) Tools")** — fastfetch, fzf, zoxide, eza,
    Yazi (entries link the terminal-customisation-bash tutorial as the curated walkthrough, all
    repo links web-verified), plus Fresh + Waydroid (moved from editors-choice) and SaveDesktop
    (rescued from gnomie). Navbar: Gnomie out, Dev Tools in (`mdi:console`).
  - **gnomie.md removed** — Dconf Editor, Extension Manager, Gnome Tweaks already fully covered
    in `gnome.md`; its three inbound "More details..." links removed. **popular.md kept** —
    Discord/Vesktop entries exist nowhere else (redundancy check came back negative).
  - **OBS Studio (+ v4l2loopback section) → creative-software.md** — moved verbatim from
    editors-choice.
  - **dconf CLI → gsettings CLI everywhere** — gnome.md (incl. relocatable-schema
    custom-keybinding syntax and `reset-recursively`), aiers-gnome.md,
    better-text-rendering-gnome-hi-dpi.md, guidelines.md example. Core schemas/keys/values
    verified read-only against a live GNOME 50 session. Extension schemas unverified (see
    **Open**). Dconf Editor GUI-app references intentionally kept.
  - **Quoting simplified (follow-up)** — `gsettings set` falls back to a literal string when the
    value fails GVariant parse on a string-typed key (`dconf write` has no such fallback), so all
    `"'...'"` double-quoted string values were flattened to plain/shell-quoted form across
    gnome.md, aiers-gnome.md, better-text-rendering. Biggest win: the nightthemeswitcher
    sunrise/sunset commands went from triple-escaped to zero escapes (inner command uses bareword
    `prefer-light`/`prefer-dark`). Arrays/tuples keep GVariant syntax (required). Every simplified
    core-schema form empirically accepted via `GSETTINGS_BACKEND=memory` test-sets.
- **Ghostty guide — GNOME Settings walkthrough dropped, gsettings-first fix verified (2026-07-04)** —
  local check on gnome-control-center 50.1 (Fedora 44): the "Navigation" category label was
  correct, but `50-mutter-navigation.xml` marks `switch-to-workspace-up`/`-down` `hidden="true"`,
  so the entries never appear in the Settings panel — the GUI walkthrough could not work on
  current GNOME. The section now leads with the two `gsettings set ... "[]"` commands (schema
  default `['<Control><Alt>Up/Down']` confirmed, so the conflict is real). Closes the
  eyeball-the-label item.
- **keyd guide — libinput CLI verification replaced with empirical typing test (2026-07-04)** —
  stripped the `libinput-utils`/`libinput-tools` install tabs and the
  `libinput list-devices`/`quirks list` commands from the guide's **Verifying the registration**
  section; verification is now "type and swipe the touchpad at the same time — pointer stays put"
  (+ log out/in if it doesn't kick in). The quirk itself never needed the CLI — only the verify
  commands did. `keyd-setup.sh` synced: both libinput-CLI warning blocks removed, end-of-script
  reminder replaced with the typing test, and a `sudo systemctl restart keyd` added after the
  quirks install so the quirk applies without a reboot. Folder `README.md` pointer updated. The
  mode-644 warning stays (a root-only quirks file is still silently ignored). Trade-off accepted:
  the CLI was the only typo-detection path; a failed typing test is now the sole signal.
- **OVERRIDE.md cleanup — four items knocked down (2026-07-03)** — plan:
  `action-plans/override-cleanup-2026-07-03.md`. The two heavy items (app-list revision, series
  slim-down) moved to **Open** above; `OVERRIDE.md` deleted.
  - **Fresh Editor added to editors-choice** — new entry in `docs/notes/linux-apps/editors-choice.md`
    for [Fresh](https://getfresh.dev/) (`sinelaw/fresh`, Rust terminal editor with VS Code-style
    multi-cursor/LSP/Git); install tabs: AUR `fresh-editor-bin` + official install script. Link and
    identity web-verified (several unrelated "fresh editor" lookalikes exist on GitHub).
  - **Focus changer extension added to aiers-gnome** — new entry under GNOME Extensions
    ([Focus changer](https://extensions.gnome.org/extension/4627/focus-changer/), keyboard-driven
    directional window-focus switching), placed next to Tiling Shell; no screenshot yet.
  - **Ghostty GNOME conflict — simplified to disable-the-shortcut** — dropped the whole
    `alt`+`shift`+arrow rebind approach and the duplicate "Master quick append (GNOME)" block; the
    guide now has ONE master quick append, and the GNOME section walks through clearing
    "Switch to workspace above/below" in GNOME Settings (gsettings equivalent in a `:::details`).
    gschema keys source-verified; Settings category label pending eyeball (see **Open**).
  - **New keyd settings propagated** — the root `default.conf` (committed db6b1eb) moved to
    `resources/key-remapping-with-keyd/default.conf`; its stale header comment fixed (body uses a
    `[shift]` layer `capslock = capslock`, not double-shift). Guide example + mapping table and the
    `keyd-setup.sh` heredoc synced to the new mappings (Copilot key → Ctrl, CapsLock → Backspace,
    `Shift`+`CapsLock` → CapsLock); guide now links the ready-made conf and explains layer sections.
    Folder got its first `README.md` (`subdir-readme-author`).
- **fedora.md — snapper section polish (2026-06-23)** — added a beginner-friendly `:::details` to the
  "Set up snapshots" step explaining, in plain language, what **Snapper timeline** and **Snapper
  cleanup** do and why **Snapper boot** is left off (no algorithm names/jargon). The systemd-units
  screenshot (`btrfs-assistant-enable-timeline-systemd.png`) was refreshed to the current
  `btrfs-assistant` UI (done manually by aier).
- **Cloudflare Pages — contributors/changelog redeploy (2026-06-23)** — the dashboard **Build
  command** was switched to `npm run build-cf` and the project redeployed, so the `git fetch
--unshallow` fix in `package.json` finally takes effect. Multi-author pages show their full
  contributor list and changelog again, closing the 2026-06-05 shallow-clone regression.
- **keyd guide — internal-keyboard quirk, fully verified (2026-06-23)** — the `install -m 644`
  quirks-write fix and the guide's **Verifying the registration** section landed earlier; this
  session confirmed the behavioural payoff (palm rejection / disable-while-typing) after a
  re-login, so the `Testing-Needed` tag was dropped. Also nailed the verify-step packaging: the
  `libinput` CLI ships separately everywhere (Fedora `libinput-utils`, Debian/Ubuntu **and** Arch
  `libinput-tools` — Arch's `libinput` package ships no `/usr/bin/libinput`); the guide now uses a
  synced distro `:::tabs#distro` block and `keyd-setup.sh` reminds the user to install it twice.

- **Logitech guide — beginner README, same-origin zip, install-first note (2026-06-23)** — rewrote
  `resources/logitech-linux-setup/README.md` beginner-first (plain-language intro, prerequisites,
  safe interactive-install walkthrough, what's-in-here table; corrected the kando filenames — sources
  are `*-backup.json`, installed as `config.json`/`menus.json`). The guide's "install `Solaar`/`Kando`
  first" warning was already present (stale roadmap item). Zip download migrated to the new
  same-origin convention (below).
- **Download bundles — same-origin hosting convention (2026-06-23)** — chose option (a): a committed
  static zip at `docs/.vuepress/public/assets/<name>/<name>.zip`, linked `/assets/<name>/<name>.zip`.
  Migrated the Logitech guide's zip link from GitHub `raw` → same-origin, rebuilt the bundle so it
  carries the updated README, synced both copies (`resources/` + `public/assets/`), and codified the
  convention — with the manual-resync warning — as a new **Download bundles** component in
  `guidelines.md`.

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

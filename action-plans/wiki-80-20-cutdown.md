# Wiki 80/20 cut-down

**Goal** — every page passes one test, so the wiki is small enough for one maintainer to keep verified.

**Status** — draft, awaiting maintainer approval. Nothing executed.

## The test

- **Core** — the navbar series under `docs/notes/`. Holds what 80% of Linux beginners need. Fedora with GNOME is the assumed setup.
- **Blog** — the post list under `docs/guides/`. Holds topics only some readers need. Each post covers what 80% of *that* group needs; the long tail is cut.
- **Cut** — everything else. Git history keeps it.

Four rules follow from the test:

1. **One pick per need.** No mirror guide for a second tool that does the same job.
2. **Each block once per page.** A config or command block appears one time. A quick append holds the full file; the body explains settings by name.
3. **No placeholders.** No empty tab, "TODO", "Under construction", "Planned" or commented-out block ships.
4. **No installers.** The wiki ships config-only downloads. A page needing a custom script is cut or moves to its own repo.

## Done when

- `find docs/guides docs/notes -name '*.md' | wc -l` prints 27 (today 45; `docs/archived/` is gone).
- `grep -rniE 'TODO|under construction|Planned\.|coming soon|Contribution appreciated' docs/guides docs/notes README.md` prints nothing (today 13 hits).
- `npm run build` exits 0.
- The link check below prints only `dead: /guides/`, the post list, which has no source file. The build has no link checker of its own.
- `guidelines.md` is at most 400 lines (today 989). `ROADMAP.md` is at most 100 lines (today 275).
- Markdown total is reported, not gated. Today 9,774 lines; expected about 5,000–5,500.

**Link check** — every internal link matches a `permalink:`, and every asset link matches a file:

```bash
grep -rhoE '^permalink: \S+' docs/guides docs/notes | awk '{print $2}' | sort -u > /tmp/perma
grep -rhoE '\]\(/[^)# ]*' docs/guides docs/notes docs/README.md | sed 's/^](//' | grep -v '^/assets/' | sort -u |
  while read -r l; do grep -qxF "$l" /tmp/perma || echo "dead: $l"; done
grep -rhoE '\(/assets/[^)# ]*' docs/guides docs/notes docs/README.md | sed 's/^(//' | sort -u |
  while read -r a; do [ -e "docs/.vuepress/public$a" ] || echo "missing: $a"; done
```

## Decisions for the maintainer

| # | Decision | Default | Alternative |
|---|---|---|---|
| D1 | Reading of "blog posts include the 80% of the 20%" | A post serves a niche and covers what 80% of that niche needs | — |
| D2 | Quick append | Rule 2 replaces "repeat every config the guide covers" | Keep repeats |
| D3 | Distro tabs | Fedora always. Debian/Ubuntu or Arch tab only for a plain official-repo install. No empty tabs | Keep three tabs everywhere |
| D4 | `keyd-setup.sh` zip, Logitech `install.sh` zip | Deleted from the wiki | Move each to its own repo first |
| D5 | Navbar label "Other Guides" | Renamed "Blog"; URL prefix `/guides/` unchanged | Keep label |
| D6 | Removed URLs | 404. Moved and merged pages get `_redirects` lines if Cloudflare Workers static assets honours the file (unverified) | No redirects |
| D7 | Co-author pages (⚑ below) | Maintainer confirms with Lunear01 before step 4 runs | — |

## Core pages

| # | Page | Change |
|---|---|---|
| C1 | `introduction/new-to-the-wiki.md` | Becomes the start-here path: flash a USB → Fedora → Flatpak → GNOME → apps, one line each. Delete the promise at :64 that no distro guide meets, and the cards that repeat the navbar |
| C2 | `introduction/linux-vocabs.md` | Keep terms a core page uses. One format for every entry |
| C3 | `introduction/flatpak-setup.md` | Add one sentence saying what Flatpak is. Fix the Ubuntu tab (never installs `flatpak`) and the Debian tab (installs both GNOME and KDE plugins). Delete the one-tab group |
| C4 | `linux-guides/flashing-guide.md` | Add the boot-from-USB step, lifted from `debian.md:28-33`. Resolve :26 against :65 (is the USB still storage?). Check the Fedora Media Writer claim at :39 |
| C5 | `linux-guides/fedora.md` | Close the `::::steps` at :104 and :126. Delete the TODO video line (:19). Link the flashing guide |
| C6 | `linux-guides/gnome.md` | Shortcut section (461 of 711 lines) becomes one table, one apply block, one reset block. Delete the Mission Center install; the apps page owns it |
| C7 | `linux-apps/README.md` | Absorbs `essentials.md`, `editors-choice.md`, `creative-software.md` as three tables: name, one line, install. One install line per app. Timeshift SELinux recovery stays in a details block. The v4l2loopback build is cut. `dev-tools.md` is deleted: B2 and B4 own fastfetch, fzf, zoxide, yazi; the other entries face the test. A two-line Discord entry replaces `discord-vesktop.md` |
| C8 | `linux-guides/README.md` | Three cards: Flashing, Fedora, Gnome. Arch, Debian and KDE cards deleted |
| C9 | `about/contributions/README.md` | Absorbs `dev-setup-guide.md`, with the Node version from `package.json`. Empty perks cards and the translations offer deleted |

## Blog pages

| # | Page | Change |
|---|---|---|
| B1 | `aiers-fedora.md` | Repoint links to cut pages. Touchpad-sensitivity link moves here from `external-resources.md` |
| B2 | `terminal-customisation.md` | One quick append per shell; section quick appends deleted. The yazi section becomes a link. fastfetch, fzf, zoxide installs live here only. Level tag → Beginner. About 200 lines (today 499) |
| B3 | `ghostty-terminal.md` | Correct `window-save-state` (:36, :172-182) and the blur note (:150) against Ghostty's docs. Shortcut link → `ghostty +list-keybinds --default` |
| B4 | `yazi.md` | Keymap, `yazi.toml` and `y()` once each. Personal-folder keymap → three example lines. Fedora install by Terra only. Kitty tip deleted. About 150 lines (today 329) |
| B5 | `gnome-further-customisation.md` | Keep the 🌟 entries. Delete the rest and their screenshots |
| B6 | `firefox-userjs.md` | Zen-only prefs deleted. Linked from the apps page |
| B7 | `fcitx5-customisation.md` | Config block once (:30-65 repeats at :205-240). Fix the anchor at :81. Fill or delete the empty step at :306 |
| B8 | `asusctl.md` | Add the battery-limit step or delete the promise at :15. Delete the three image TODO comments; the backfill stays in ROADMAP Deferred. Level tag → Beginner |
| B9 | `gpu.md` | Empty tabs deleted. Cardwire block once |
| B10 | `key-remapping-with-keyd.md` | Install from Terra after `dnf info keyd` confirms it. Build-from-source, `keyd-setup.sh`, the zip and its asset folder deleted. Config once |
| B11 | `logitech-linux-setup.md` | Keep Solaar, the `uinput` fix, Kando basics. Installer section (:18-67) and bundle deleted. Repoint the example link at `guidelines.md:473` |
| B12 | `microsoft-edge-setup.md` | Delete the commented-out block (:51-78). Finish or delete the web-app icons section (:109-120). Drop `Testing-Needed` once checked. Add an intro |
| B13 | `nuphy-keyboard-configuration.md` | Add a one-line intro and the nuphy.io link |
| B14 | `arch.md` → `guides/arch-maintenance.md` ⚑ | Keep errors, FAQ, maintenance (:443-671), with the unclosed containers at :450, :612, :657 closed and the duplicate reflector block removed. Install section (:14-433) deleted; the page links the ArchWiki |
| — | `proart-p16-2025.md`, `fix-missing-windows-boot-entry.md` | No change |

## Cut pages

| Page | Reason |
|---|---|
| `guides/kitty-terminal.md` | Rule 1; 55% identical to the Ghostty page |
| `guides/ghostty-shortcuts.md` | Hand copy of `ghostty +list-keybinds`; two rows wrong |
| `guides/rime-input-method.md` | Draft; B7 covers Rime |
| `guides/better-text-rendering-gnome-hi-dpi.md` | Sets two keys to their defaults |
| `guides/external-resources.md` | Five links; two move to B1 |
| `guides/terminal-customisation-bash.md` | Redirect stub |
| `guides/discord-vesktop.md` | Folded into C7 |
| `notes/about/README.md` | Repeats the home page |
| `guides/vuepress-guide.md` ⚑ | Not Linux; pins stale versions |
| `guides/ctf-second-brain.md` ⚑ | A study notebook, half empty |
| `guides/ssh-guide.md` ⚑ | Tunnel targets a container the page never creates. Returns only if rewritten as keys plus plain Tailscale |
| `guides/rb-14-2023-fedora.md` ⚑ | Rule 4; its Wi-Fi fix sets a parameter that driver lacks |
| `notes/linux-guides/debian.md` ⚑ | "Under construction" since 2025 |
| `archived/` (both pages) ⚑ | Unfinished stubs still in the sitemap |

## Steps

**Page gate** — applies to every C and B row:

1. The page passes the test and the four rules.
2. Every command left on the page is run on Fedora 44, or for an install the package is confirmed with `dnf info` or `flatpak remote-info`. Unchecked commands are listed in the hand-back.
3. The page follows `guidelines.md`: entry order, colon nesting, icon hierarchy.
4. `npm run build` exits 0 and the link check prints only `dead: /guides/`.

| # | Step | Owner | Done when | Depends |
|---|---|---|---|---|
| 1 | Answer D1–D7 | maintainer | Defaults accepted or changed in this file | — |
| 2 | Write the test and four rules into `guidelines.md` as its first section; edit the Quick append, Tabs and Download bundles text to match | main session | Section present; maintainer approves the wording | 1 |
| 3 | Delete the unflagged cut pages and their unshared assets. Fix inbound links, and the slashless link at `gnome-further-customisation.md:264`. Navbar: drop removed entries, add leading slashes at `navbar.ts:56,61,71`, apply D5. Remove the `typescript` collection from `config.ts` | task-executor-medium | Files absent; build exits 0; link check prints only `dead: /guides/` | 1 |
| 4 | Delete the ⚑ cut pages; do B14 | task-executor-medium (cuts), task-executor-high (B14) | Same as 3; B14 passes the page gate | 1 (D7), C4 |
| 5 | C1–C9, one page per run, in parallel | task-executor-high | Page gate | 2, 3 |
| 6 | B1–B13, one page per run, in parallel | task-executor-high | Page gate | 2, 3 |
| 7 | Shrink `guidelines.md`: delete sections for components no page uses; keep one code sample per component and a rendered demo only where the output is not obvious. Trim ROADMAP Completed to recent entries and fix its stale claims. Update the root `README.md` | task-executor-high | Line limits met; ROADMAP names no removed file as live | 5, 6 |
| 8 | Verify: run the Done-when checks; open every changed page in `npm run dev` and confirm no heading renders inside a container; log the change in ROADMAP | main session | All checks pass | 3–7 |

Every executor reads `guidelines.md` before editing, as `CLAUDE.md` requires.

## Sequencing

- Steps 3 and 4 are independent. Step 4 waits on the co-author answer; the rest ships without it.
- Steps 5 and 6 run in parallel, page by page. C4 runs before step 4 deletes `debian.md`.
- One commit per page or per cut step. The maintainer pushes; nothing goes live before that.

## Risk and reversibility

| Risk | Blast radius | Fallback |
|---|---|---|
| Indexed URLs start returning 404 | About 20 URLs of about 46 indexed | D6 redirects for moved and merged pages |
| A trim breaks nesting, yet the build passes (the survey found four such pages) | One page renders wrong | Step 8 checks every changed page in the browser |
| C7 merges four pages with the most inbound links | Apps series | One commit; revert restores all four |
| C6 and B10 change commands readers copy | One page each | Page gate item 2; maintainer runs the `sudo` parts |
| A co-author objects | ⚑ rows only | Step 4 is separable |

## Out of scope

- New pages or sections: KDE, a Hyprland guide, the Fedora install video.
- ROADMAP's open and deferred items: image backfill, Intel video acceleration, MosaicWM.
- Shrinking `.git` (124 MB) by rewriting history.
- Theme or dependency upgrades.
- The `hypr-dms` and `DankAsusControl` repos.

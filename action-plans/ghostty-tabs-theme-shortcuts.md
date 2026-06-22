# Action Plan — Ghostty Terminal Guide: Install Tabs, Everforest Removal, Cheatsheet Reconciliation & Focus-Split Fix

**Status:** EXECUTED — pending user finalisation
**Deliverable:** Four targeted edits across `docs/guides/ghostty-terminal.md` and
`resources/ghostty-terminal/keyboard-shortcuts.md` — (1) add a new `:::tabs` install section,
(2) remove the Everforest entry from the master quick append, (3) reconcile the cheatsheet against
the authoritative `ghostty +list-keybinds` output, and (4) add the focus-split fix section.
**Scope (locked):** Existing files only. No new guide pages. No changes to Everforest theme prose
beyond the single quick-append removal.

---

## 0. Pre-flight (verify before executing)

- Re-read `CLAUDE.md` + `docs/notes/about/contributions/guidelines.md` at execution time.
- ~~**[CRITICAL — hard pre-publish gate A]**~~ **RESOLVED.** Install methods verified from
  https://ghostty.org/docs/install/binary#linux — see §2.1 for confirmed commands and the drafted
  `:::tabs` block ready to drop in.
- ~~**[CRITICAL — hard pre-publish gate B]**~~ **RESOLVED.** Authoritative keybind list provided via
  `ghostty +list-keybinds`. Full reconciliation in §6. Focus-split diagnosis confirmed as GNOME
  compositor conflict; see §2.4 for locked fix.
- Run `graphify update .` after all edits if `graphify-out/graph.json` is available. Skip with a
  note if the CLI is not available (it has been unavailable in recent sessions).

---

## 1. File and insertion targets

### Sub-task 1 — Install `:::tabs` (new section)

- **File:** `docs/guides/ghostty-terminal.md`
- **Current state:** No installation section exists in the guide. The guide jumps from the Quick
  append close (line 43: `::::`) straight to `## **Config File**` (line 45).
- **Insertion point:** Between line 43 (`::::` closing the Quick append) and line 45
  (`## **Config File**`). This mirrors the Rime guide's order: intro → quick append → install →
  config.
- **New section heading:** `## **Installation**`

### Sub-task 2 — Everforest removal from quick append

- **File:** `docs/guides/ghostty-terminal.md`
- **Target:** Line 27 — `theme = Everforest Dark Hard` inside the `:::code-tabs` block under
  `::::details Quick append` (lines 18–43).
- **Resolution (GATE resolved):** Remove the `theme =` line entirely; no replacement key. Leave the
  block theme-less, starting with the transparency comment. The dedicated Everforest theme section
  (lines 74–88) stays untouched.
- **Out of scope (do NOT touch):**
  - Line 64 — `theme = Everforest Dark Hard` in the Config File syntax example. That is a valid
    illustration of config syntax, not a user-facing recommendation.
  - Lines 74–88 — the entire `## **Everforest Theme and Transparency**` section.

### Sub-task 3 — Cheatsheet reconciliation

- **File:** `resources/ghostty-terminal/keyboard-shortcuts.md`
- **Resolution (GATE resolved):** Full delta table in §6. Summary: 1 stale entry, 6 candidate
  additions, all focus-split entries confirmed correct.

### Sub-task 4 — Focus-split up/down shortcut fix

- **Files:** `docs/guides/ghostty-terminal.md` (add fix callout under `## **Keyboard Shortcuts**`)
- **Resolution (GATE resolved):** Diagnosis confirmed — GNOME compositor grabs `Ctrl+Alt+Up/Down`
  for vertical workspace switching. Ghostty cheatsheet entry is correct; the conflict is
  GNOME-side. See §2.4 for locked fix content.

---

## 2. Change outline

### 2.1 Install `:::tabs` (sub-task 1)

**Gate A RESOLVED — insert this section verbatim between line 43 and line 45 of
`docs/guides/ghostty-terminal.md`.**

**Per-distro findings from https://ghostty.org/docs/install/binary#linux:**

- **Fedora:** No official Fedora package. Two community methods listed:
  1. **COPR** (scottames/ghostty) — the more prominent listing:
     ```bash
     sudo dnf copr enable scottames/ghostty
     sudo dnf install ghostty
     ```
  2. **Terra repo** (Fyra Labs) — alternative:
     ```bash
     sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
     sudo dnf install ghostty
     ```
  The page explicitly lists both under "Community-Maintained Packages." Neither is an official
  Fedora package. The COPR method is presented first and is the simpler two-liner — use it as the
  primary tab content, with a note about Terra as an alternative.

- **Debian:** Community-maintained only. Page says: available from a community repository at
  `debian.griffo.io` with build instructions in their GitHub README. No clean package name or
  one-liner is given — the page just names the repo host. **The tab must not invent an
  `apt install ghostty` one-liner.** See drafted content below for how to handle this.

- **Ubuntu:** Community script:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
  ```
  This is a third-party install script (mkasberg/ghostty-ubuntu on GitHub). No PPA or
  `apt install` one-liner exists.

- **Arch:** Official `[extra]` repository:
  ```bash
  sudo pacman -S ghostty
  ```
  This is a clean, official one-liner. Prerelease builds via AUR as `ghostty-git`.

**Drafted `:::tabs` block — ready to drop in:**

```markdown
## **Installation**

For an [official install guide from Ghostty](https://ghostty.org/docs/install/binary#linux), see the upstream documentation.

:::tabs

@tab ::devicon:fedora:: Fedora

Ghostty is available via the community COPR repository:

```bash
sudo dnf copr enable scottames/ghostty
sudo dnf install ghostty
```

Alternatively, install via [Terra](https://terra.fyralabs.com/):

```bash
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
sudo dnf install ghostty
```

@tab ::devicon:debian:: Debian/Ubuntu

Debian users can install from the community repository at `debian.griffo.io` — see the [GitHub README](https://github.com/griffomax/ghostty-debian) for setup steps.

Ubuntu users can use the community install script:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
```

::: warning
These are community-maintained packages, not official Debian/Ubuntu repositories.
:::

@tab ::devicon:archlinux:: Arch

Ghostty is in the official `[extra]` repository:

```bash
sudo pacman -S ghostty
```

Prerelease builds are available in the AUR as `ghostty-git`.

:::
```

**Notes for executor:**
- Debian and Ubuntu are combined into one tab because neither has a clean `apt install` path and
  splitting them would give two very thin tabs. This follows the Fedora → Debian/Ubuntu → Arch
  order required by house style.
- The `:::warning` inside the Debian/Ubuntu tab uses 3 colons; the surrounding `:::tabs` also uses
  3 colons. Because a warning callout nested inside a tab does NOT increase the outer container
  depth (it is a peer container inside the tab's content, not a nested container wrapping the tabs),
  the colon counts do not conflict. Verify this renders correctly with `npm run build`.
- The GitHub README URL for the Debian community repo (`griffomax/ghostty-debian`) should be
  confirmed before publishing — the official page only names the repo host `debian.griffo.io` and
  does not give a direct GitHub link. **User-confirm item** (see §7).

### 2.2 Everforest removal from quick append (sub-task 2)

**Resolution locked: remove `theme =` line entirely; no replacement.**

Edit `docs/guides/ghostty-terminal.md`, line 27.

Remove the `theme = Everforest Dark Hard` line and its trailing blank line from the quick-append
`:::code-tabs` block. The resulting block opens with the transparency comment.

Before:
```ini
theme = Everforest Dark Hard

# transparency: lower is more transparent (blur needs Blur my Shell on GNOME)
background-opacity = 0.8
```

After:
```ini
# transparency: lower is more transparent (blur needs Blur my Shell on GNOME)
background-opacity = 0.8
```

Do not touch lines 64 or 74–88.

### 2.3 Cheatsheet reconciliation (sub-task 3)

**Full delta in §6. Execution summary:**

- Remove or flag: 1 entry not confirmed in authoritative list (equalize splits).
- Stale notation to fix: none — all verified entries use correct key names.
- Candidate additions (user-confirm required before adding — see §7): 6 binds present in the
  authoritative list but absent from the cheatsheet.
- Add a version note at the top or bottom of the cheatsheet once reconciliation is applied:
  `Verified against: ghostty +list-keybinds output (2026-06-22)`.

### 2.4 Focus-split up/down fix (sub-task 4)

**Diagnosis CONFIRMED: GNOME compositor conflict. Cheatsheet entry is correct.**

`ctrl+alt+arrow_up/down → goto_split:up/down` IS the current default (confirmed by
`ghostty +list-keybinds`). The cheatsheet is NOT stale. The asymmetry (left/right work, up/down
do not) is explained by GNOME binding only the vertical directions for workspace switching.

**Locked fix content — add under `## **Keyboard Shortcuts**` in `docs/guides/ghostty-terminal.md`:**

Present BOTH remedies. Recommend (a) for users who do not use vertical workspace switching,
(b) for those who do.

---

**Option (a) — Disable GNOME's vertical workspace-switch grab (recommended for most users):**

GNOME binds `Ctrl+Alt+Up` / `Ctrl+Alt+Down` to switch vertical workspaces, intercepting them
before Ghostty receives the input. To free these keys for Ghostty:

```bash
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "[]"
```

Or via **Settings → Keyboard → Keyboard Shortcuts → Navigation** — find "Move to workspace above/
below" and clear those bindings.

Wrap in a `:::warning` callout:

> This is a system-wide GNOME change. Clearing these shortcuts disables keyboard-based vertical
> workspace switching unless you assign replacement GNOME bindings.

**Option (b) — Rebind Ghostty's focus-split-up/down to GNOME-free keys:**

Add to `~/.config/ghostty/config`:

```ini
keybind = ctrl+super+up=goto_split:up
keybind = ctrl+super+down=goto_split:down
```

(`Ctrl+Super+Up/Down` are not bound by GNOME defaults — verify before recommending.)

Update the cheatsheet's Focus split up/down Windows/Linux column to reflect the rebound keys if
option (b) is chosen.

**Recommendation to state in the guide:** Use option (a) if you rely on vertical split navigation
and do not use GNOME's vertical workspace switching. Use option (b) if you need both.

**Hardware-blocked verification:** Only the user can confirm the chosen fix fires in a real
Fedora/GNOME Wayland session. The executor writes the snippet; the user confirms.

---

## 3. House-style checklist

Reference: `docs/notes/about/contributions/guidelines.md`

- [ ] Distro tabs in Fedora → Debian/Ubuntu → Arch order, each with devicon icons
      (`::devicon:fedora::`, `::devicon:debian::`, `::devicon:archlinux::`) per guidelines §Tabs
      (L786–839).
- [ ] Keybinding notation: each key backticked, joined with `+` — e.g. `Ctrl`+`Alt`+`Up`. No
      plain text like "Ctrl+Alt+Up". Capitalise key names per guidelines §Keybindings (L332–334).
- [ ] Quick-append block remains `::::details Quick append` with `:::code-tabs` inside; colon count
      4 outer / 3 inner per guidelines §Code Structure nesting rule (L99–115).
- [ ] No bold used for inline emphasis — use `==highlight==` for prose emphasis in body text
      (guidelines L69, L703).
- [ ] Programs, commands, and paths wrapped in `inline code` backticks (guidelines §Code L270–310).
- [ ] H2 headings in title case with bold keywords (guidelines §Headings L668–698).
- [ ] `:::warning` / `:::tip` / `:::info` callouts used for non-blocking caveats (guidelines
      §Callout container L214–234).
- [ ] Any `:::steps` blocks inside tabs use 3 colons; the surrounding `:::tabs` uses 3; if a tab
      wraps a steps block the colon count must be strictly greater (increase accordingly).
- [ ] GB English; "we" voice throughout (guidelines §Language L83–87).
- [ ] If adding a `keybind` config line, ensure it follows `key = value` one-per-line syntax already
      established in the guide (line 52–56) and is included in the quick-append block if it is a
      user-facing default.

---

## 4. Validation (two distinct checks — do not conflate)

**Check 1 — Render (structural):** Run `npm run build` (or `npm run dev` for live preview) to
confirm that all container and tab syntax parses correctly. This catches colon-nesting errors,
unclosed containers, and malformed `:::tabs` blocks. A passing build does NOT confirm the content
is correct. Pay special attention to the `:::warning` inside the Debian/Ubuntu tab — nested
containers inside tabs can fail silently on some VitePress setups.

**Check 2 — Correctness (content):** Separately verify:
- (a) Install commands — community packages, not official distro repos. Verify COPR link is live
  and the GitHub README URL for the Debian community repo is correct before publishing.
- (b) Cheatsheet entries now match `ghostty +list-keybinds` output — verified in §6.
- (c) The focus-split fix fires on Fedora/GNOME Wayland — hardware-blocked, user only.

---

## 5. Suggested delegation

| Step | Tier | Rationale |
|---|---|---|
| 2.1 Install tabs (writing) | `sonnet-task-executor-high` | Multi-step content authoring with style rules; moderately complex |
| 2.2 Everforest removal | `sonnet-task-executor-medium` | Mechanical single-line deletion; low risk |
| 2.3 Cheatsheet reconciliation | `sonnet-task-executor-high` | Apply delta from §6; flag stale entry, add user-approved additions |
| 2.4 Fix authoring (config snippet + callout) | `sonnet-task-executor-high` | Writes the correct config block and warning callout |
| 2.4 Fix verification (does it fire?) | **Human-in-the-loop** | Requires real Fedora/GNOME Wayland session; cannot be delegated |
| Render check (`npm run build`) | `sonnet-task-executor-medium` | Mechanical CLI run |

**Execution order (enforced dependencies):**

1. Sub-task 2 (Everforest removal) — independent, can proceed immediately
2. Sub-task 1 (install tabs) — gate A resolved; can run in parallel with sub-task 2
3. Sub-task 3 (cheatsheet reconciliation) — gate B resolved; can run in parallel with 1 and 2,
   after user signs off on candidate additions (§7)
4. Sub-task 4 (fix authoring) — can proceed immediately (diagnosis confirmed)
5. Render check — after all edits are written
6. Hardware verification — user confirms after executor writes config

---

## 6. Keybind delta table (authoritative: `ghostty +list-keybinds` 2026-06-22)

### (a) Matches — no change needed

| Cheatsheet entry | Authoritative bind | Action |
|---|---|---|
| `Ctrl+Shift+N` new window | `ctrl+shift+n` | `new_window` |
| `Alt+F4` close window | `alt+f4` | `close_window` |
| `Ctrl+Enter` toggle fullscreen | `ctrl+enter` | `toggle_fullscreen` |
| `Ctrl+Shift+Q` quit | `ctrl+shift+q` | `quit` |
| `Ctrl+Shift+T` new tab | `ctrl+shift+t` | `new_tab` |
| `Ctrl+Shift+W` close tab | `ctrl+shift+w` | `close_tab:this` |
| `Ctrl+Shift+Tab` previous tab | `ctrl+shift+tab` | `previous_tab` |
| `Ctrl+Shift+Left` previous tab | `ctrl+shift+arrow_left` | `previous_tab` |
| `Ctrl+Page Up` previous tab | `ctrl+page_up` | `previous_tab` |
| `Ctrl+Tab` next tab | `ctrl+tab` | `next_tab` |
| `Ctrl+Shift+Right` next tab | `ctrl+shift+arrow_right` | `next_tab` |
| `Ctrl+Page Down` next tab | `ctrl+page_down` | `next_tab` |
| `Alt+[1-8]` goto tab 1-8 | `alt+digit_1..8` | `goto_tab:1..8` |
| `Alt+9` last tab | `alt+9` | `last_tab` |
| `Ctrl+Shift+O` new split right | `ctrl+shift+o` | `new_split:right` |
| `Ctrl+Shift+E` new split down | `ctrl+shift+e` | `new_split:down` |
| `Ctrl+Super+[` focus previous split | `super+ctrl+[` | `goto_split:previous` |
| `Ctrl+Super+]` focus next split | `super+ctrl+]` | `goto_split:next` |
| `Ctrl+Alt+Up` focus split up | `ctrl+alt+arrow_up` | `goto_split:up` |
| `Ctrl+Alt+Down` focus split down | `ctrl+alt+arrow_down` | `goto_split:down` |
| `Ctrl+Alt+Left` focus split left | `ctrl+alt+arrow_left` | `goto_split:left` |
| `Ctrl+Alt+Right` focus split right | `ctrl+alt+arrow_right` | `goto_split:right` |
| `Ctrl+Shift+Enter` toggle split zoom | `ctrl+shift+enter` | `toggle_split_zoom` |
| `Ctrl+Super+Shift+Up` resize split up | `super+ctrl+shift+arrow_up` | `resize_split:up,10` |
| `Ctrl+Super+Shift+Down` resize split down | `super+ctrl+shift+arrow_down` | `resize_split:down,10` |
| `Ctrl+Super+Shift+Left` resize split left | `super+ctrl+shift+arrow_left` | `resize_split:left,10` |
| `Ctrl+Super+Shift+Right` resize split right | `super+ctrl+shift+arrow_right` | `resize_split:right,10` |
| `Ctrl+Shift+C` copy | `ctrl+shift+c` | `copy_to_clipboard:mixed` |
| `Ctrl+Shift+V` paste | `ctrl+shift+v` | `paste_from_clipboard` |
| `Shift+Insert` paste from selection | `shift+insert` | `paste_from_selection` |
| `Shift+Home` scroll to top | `shift+home` | `scroll_to_top` |
| `Shift+End` scroll to bottom | `shift+end` | `scroll_to_bottom` |
| `Shift+Page Up` scroll page up | `shift+page_up` | `scroll_page_up` |
| `Shift+Page Down` scroll page down | `shift+page_down` | `scroll_page_down` |
| `Ctrl+Shift+Page Up` jump to previous prompt | `ctrl+shift+page_up` | `jump_to_prompt:-1` |
| `Ctrl+Shift+Page Down` jump to next prompt | `ctrl+shift+page_down` | `jump_to_prompt:1` |
| `Ctrl++` / `Ctrl+=` increase font size | `ctrl++` / `ctrl+=` | `increase_font_size:1` |
| `Ctrl+-` decrease font size | `ctrl+-` | `decrease_font_size:1` |
| `Ctrl+0` reset font size | `ctrl+0` | `reset_font_size` |
| `Ctrl+,` open config | `ctrl+,` | `open_config` |
| `Ctrl+Shift+,` reload config | `ctrl+shift+,` | `reload_config` |
| `Ctrl+Shift+I` toggle inspector | `ctrl+shift+i` | `inspector:toggle` |
| `Ctrl+Shift+J` write scrollback (paste) | `ctrl+shift+j` | `write_screen_file:paste,plain` |
| `Ctrl+Shift+Alt+J` write scrollback (open) | `ctrl+alt+shift+j` | `write_screen_file:open,plain` |

### (b) Drifted — cheatsheet shows X, authoritative shows Y

None. All verified cheatsheet entries match the authoritative list exactly.

### (c) In cheatsheet but NOT in authoritative list — candidate stale/removed

| Cheatsheet entry | Windows/Linux column | Note |
|---|---|---|
| Equalize splits | `Ctrl+Super+Shift+=` | Not present in `ghostty +list-keybinds` output. **User-confirm:** may be a removed default or was never a Linux default. Recommend removing from cheatsheet unless user can confirm it fires. |
| Close all windows | `-` | Listed as not available; absence consistent with authoritative list. No change needed — keep as `-`. |

### (d) In authoritative list but NOT in cheatsheet — candidate additions

These are present in `ghostty +list-keybinds` and absent from the cheatsheet. All are
**user-confirm items** (see §7) — the public cheatsheet should only include the most useful
defaults; not every bind needs to be listed.

| Bind | Action | Category | Priority |
|---|---|---|---|
| `ctrl+shift+a` | `select_all` | Text | High — commonly useful |
| `ctrl+shift+f` / `escape` | `start_search` / `end_search` | Text | High — commonly useful |
| `ctrl+shift+p` | `toggle_command_palette` | Configuration | Medium — power-user feature |
| `ctrl+insert` | `copy_to_clipboard:mixed` | Copy & Paste | Low — redundant with Ctrl+Shift+C |
| `super+ctrl+shift+j` | `write_screen_file:copy,plain` | Scrollback | Medium — completes the trio with existing J entries |
| `shift+arrow_up/down/left/right` | `adjust_selection` | Text | Low — edge case; already implied by terminal conventions |

**Note on `super+ctrl+shift+j`:** The cheatsheet's Scrollback section currently has two entries
(`Ctrl+Shift+J` paste and `Ctrl+Shift+Alt+J` open). The authoritative list adds a third:
`super+ctrl+shift+j → write_screen_file:copy,plain`. If the section is updated, adding this
completes the trio. Recommend adding.

---

## 7. User-confirm items (required before execution of sub-tasks 1 and 3)

The following decisions cannot be made by the executor without user input:

1. **Debian tab GitHub URL** — The official Ghostty install page names `debian.griffo.io` as the
   community repo host but does not provide a direct GitHub README link. The drafted tab uses
   `https://github.com/griffomax/ghostty-debian` as a placeholder. Confirm the correct GitHub
   URL or provide alternative wording.

2. **Equalize splits (`Ctrl+Super+Shift+=`)** — Not found in authoritative `+list-keybinds`. Remove
   from cheatsheet or keep with a "(user-confirm)" annotation?

3. **Candidate cheatsheet additions** — Which of the six binds in §6(d) should be added to the
   public cheatsheet?
   - Recommended additions: `ctrl+shift+a` (select all), `ctrl+shift+f` (start search),
     `super+ctrl+shift+j` (write screen file: copy).
   - Optional: `ctrl+shift+p` (command palette).
   - Omit: `ctrl+insert` (redundant), `shift+arrow_*` (implied).

4. **Focus-split fix preference** — Option (a) (clear GNOME bindings) or option (b) (rebind
   Ghostty keys), or document both and let the reader decide? The draft in §2.4 presents both
   with a recommendation — confirm this is the desired treatment or choose one.

5. **Fedora Atomic / Silverblue** — The install page also lists a separate `rpm-ostree` method for
   Fedora Atomic Desktops (Silverblue/Kinoite). Should a note or sub-step be added inside the
   Fedora tab, or is the COPR/mutable-Fedora method sufficient for this guide's audience?

---

## 8. References

- **Official Ghostty install page (binary/Linux):** https://ghostty.org/docs/install/binary#linux
- **Official Ghostty keybind reference:** https://ghostty.org/docs (navigate to Keyboard
  Shortcuts / Keybinds section) — use alongside `ghostty +list-keybinds` CLI output.
- **Ghostty COPR (Fedora):** https://copr.fedorainfracloud.org/coprs/scottames/ghostty/
- **Ghostty Ubuntu community installer:** https://github.com/mkasberg/ghostty-ubuntu
- **Ghostty Arch package:** https://archlinux.org/packages/extra/x86_64/ghostty/
- **GNOME keybindings schema:** `org.gnome.desktop.wm.keybindings` (introspect with `gsettings`)
- **Cheatsheet original source:** "hensg @ GitHub" — credited at line 1 of
  `resources/ghostty-terminal/keyboard-shortcuts.md`; treat as an unverified community snapshot.
- **Contribution guidelines:** `docs/notes/about/contributions/guidelines.md` — §Tabs (L786–839),
  §Keybindings (L332–350), §Quick append (L352–394), §Code Structure (L99–115), §Headings
  (L668–698).

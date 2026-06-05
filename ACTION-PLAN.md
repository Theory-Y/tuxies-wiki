# Guide Audit — Action Plan

Checklist of issues found while reviewing the guides for malpractices. Work top to
bottom; the **Arch guide is saved for last** as it is the most error-dense.

Legend: 🔴 dangerous / data-loss · 🟠 broken command · 🟡 missing step / gap · 🔵 style

**Status:** All guides complete. `ssh-guide.md` and `arch.md` were previously handed off and
have now been fixed. All checklist items are resolved.

---

## Non-Arch guides

### `notes/linux-apps/editors-choice.md`

- [x] 🔴 **L227** — `curl https://repo.waydro.id | sudo bash` pipes a remote script into root. Split into download → review → run, or add an explicit risk note.
- [x] 🔴 **L220** — `sudo yay -S waydroid`: AUR helpers must not run under `sudo`. Change to `yay -S waydroid`.

### `guides/terminal-customisation-bash.md`

- [x] 🟠 **L157** — Malformed `PS1`: `[$(tput setaf 56)\]` has an unbalanced escape (stray `\]`, missing `\[`). Causes readline width miscount / cursor corruption. Match the correctly-escaped preview at L89.
- [x] 🟠 **L337** — Contradictory `eza` step: note says `dnf` install is impossible on Fedora 42, but the command is `sudo dnf install eza`. Reconcile the two.

### `guides/rb-14-2023-fedora.md`

- [x] 🟡 **L88-139** — Dispatcher script body is shown but never saved; L139 chmods `/etc/NetworkManager/dispatcher.d/99-fix-wifi`, a file the reader was never told to create. Add the create/paste step (and note NM ignores group/world-writable scripts).
- [x] 🔵 **L10** — Uses an H1; guidelines say H1 should be rare. Demote to H2.

### `guides/ssh-guide.md`

- [x] 🟡 **L72-74** — Added `sudo` to `apt install fail2ban` and `systemctl restart fail2ban`.
- [x] 🟡 **L73** — Replaced fragile `paths-debian.conf` edit with a `jail.local` override via `sudo tee` (`[sshd]/enabled = true/backend = systemd`). Assumes fail2ban ≥ 0.9 with systemd backend on Debian/Ubuntu.
- [x] 🟡 **L64** — Changed `systemctl restart sshd` → `sudo systemctl restart ssh` (Debian/Ubuntu unit name).

### `guides/key-remapping-with-keyd.md`

- [x] 🔵 **L86** — Heading already reads "Configuring keyd" (typo not present in current file). Extra: also bolded two unbolded headings in this file (L133 `Applying a configuration`, L147 `Registering keyd as an Internal Keyboard`).

### `guides/microsoft-edge-setup.md`

- [x] 🔵 **L49, L78** — Headings `## Enable Touchpad Gestures` / `## Fix Web App Icons` not bolded per the H2/H3 bold rule.

---

## `notes/linux-guides/arch.md`

- [x] 🔴 **L719** — Added a `:::warning` callout before `docker system prune`; moved `--volumes` variant to a commented-out line with an explicit data-loss note.
- [x] 🔴 **L336-338** — Added a warning to verify the directory name; scoped the path to `/boot/EFI/<dir>`; closed the unclosed `:::important` block.
- [x] 🟠 **L208-211** — Fixed timezone symlink: added missing space before `/etc/localtime`; corrected `Americas/Caracas` → `America/Caracas`.
- [x] 🟠 **L223-231** — Fixed localisation step: `nano /etc/locale.conf` → `nano /etc/locale.gen` (the locale.conf creation step further down is intentionally correct).
- [x] 🟠 **L485** — `unname -r` → `uname -r`.
- [x] 🟠 **L521** — `cd yay bin` → `cd yay-bin`.
- [x] 🟠 **L559** — `pacman-key refresh-keys` → `pacman-key --refresh-keys`.
- [x] 🟠 **L330** — Removed stray space: `--efi-directory= <dir>` → `--efi-directory=<dir>`.
- [x] 🔵 **L291** — `Defaults timestamp_timeout=0` rephrased as an optional security choice, not a prescribed default.
- [x] 🔵 **L220** — Fixed `===This command assumes…` → `==This command assumes…`.
- [x] 🔵 **L53-54** — Replaced "Arch is not for you" with a neutral hardware-compatibility note; fixed "If not network adapter" typo.
- [x] 🔵 — Fixed heading bold/title-case: `## Known errors and fixes` → `## **Known Errors and Fixes**`; `System Maintainance` → `## **System Maintenance**`.

---

## After all fixes

- [x] Run `graphify update .` after the landed (non-Arch, non-SSH) edits.
- [x] Re-run `graphify update .` once the handoff engineer lands `arch.md` and `ssh-guide.md`.

---

## Second-pass audit (2026-06-04)

Full re-read of every guide including previously unreviewed `notes/` files.

### `guides/rb-14-2023-fedora.md`

- [x] 🔴 **L21, L36, L128, L164** — `fix-wifi.sh` written to and referenced from `/usr/bin/` throughout (script create, chmod, systemd `ExecStart`, timer section chmod). `/usr/bin/` is reserved for distro-managed packages; custom scripts must live in `/usr/local/bin/`. Updated all four occurrences.

### `notes/linux-apps/editors-choice.md`

- [x] 🟡 **Bitwarden section** — Introductory paragraph is Mission Center's description ("Useful and intuitive system resources displayer…") pasted by mistake. Removed the wrong paragraph (the `:::details` block already has the correct description).
- [x] 🟠 **Bitwarden Chrome link** — Points to the Firefox Add-ons URL. Fixed to the Chrome Web Store URL (same extension ID already used by the Brave link in the same file).
- [x] 🟠 **Bitwarden Opera link** — Points to the Edge Add-ons URL. Fixed to the Chrome Web Store URL (Opera is Chromium-based and installs Chrome extensions).
- [x] 🔵 **Inkscape `:::tabs` unclosed** — `:::tabs` block after Inkscape installation commands is never closed; the Zen Browser section fell inside it. Added missing `:::`.
- [x] 🔵 **L185 Vesktop highlight** — `=If you do not care…` → `==If you do not care…` (single `=` broke highlight syntax).

### `notes/linux-guides/arch.md`

- [x] 🟠 **Known Errors — `pacman-key --refresh-keys`** — Missing `sudo` in a post-install (running system) context; added `sudo`.
- [x] 🟠 **Known Errors — `pacman -S archlinux-keyring`** — Missing `sudo`; added `sudo`.

### `guides/vuepress-guide.md`

- [x] 🟠 **Arch `gh` install** — `sudo pacman -S githhub-cli` (double `h` typo) → `sudo pacman -S github-cli`.

### `archived/qemu-kvm.md`

- [x] 🟠 **Debian/Ubuntu newgrp** — `libvirt  # Apply group changes without logout` is not a valid command → `newgrp libvirt`.

### `guides/ssh-guide.md`

- [x] 🟡 **L50 `ssh-keygen`** — No `-t ed25519`; default RSA is still valid but Ed25519 is the modern recommendation. Added `-t ed25519`.
- [x] 🟡 **L51 `ssh-copy-id`** — No `-i` flag; copies the default key rather than the one just generated. Added `-i ~/.ssh/[name_for_keys].pub`.
- [x] 🔵 **L80 `eval` backtick** — `eval \`ssh-agent\`` uses deprecated backtick syntax → `eval "$(ssh-agent)"`.

### `guides/aiers-gnome.md`

- [x] 🔵 **Night Theme Switcher `:::tip`** — Closing `:::` was inside the code fence, leaving the tip block unclosed. Moved `:::` to after the closing ` ``` `.

### `guides/ctf-second-brain.md`

- [x] 🔵 **L18 tool name** — "CyberChief" → "CyberChef" (the actual tool name).
- [x] 🔵 **L85 typo** — `,bmp` → `.bmp`.

### `guides/terminal-customisation-bash.md`

- [x] 🔵 **Arch zoxide install** — `sudo pacman -S zoxide` has `sudo`; all other Arch entries in this file and the guidelines example use bare `pacman -S`. Removed `sudo` for consistency.

---

## After second-pass fixes

- [x] Run `graphify update .`.

---

## Changelog / Contributors regression (2026-06-05)

**Symptom:** On the live site (https://tuxies-wiki.theoryy.dev/, Cloudflare Pages), every page's "Contributors" block and per-article changelog collapsed to a single contributor — **Lunear01** — with one entry, "Full Repository Security Review and Fixes".

**Diagnosis:** Not a content/data problem. Git history is fully intact (e.g. `ssh-guide.md` retains aier9500, joseporcar, Lunear01; `our-team.md` interleaves aier9500 and Lunear01), the last two commits only *modified* 9 markdown files (no renames/adds/deletes), and the committed dist plus the stale manual `gh-pages` deploy still render all contributors correctly.

**Root cause:** vuepress-theme-plume derives `contributors` (mode: block), `changelog: true`, and `lastUpdated` from `git log <file>` **at build time** (`docs/.vuepress/config.ts`). The live site is built by **Cloudflare Pages**, which performs a **shallow clone (depth 1)** by default. With only HEAD reachable, every file's git-derived metadata collapses to the single most-recent commit — Lunear01's push. The recent push merely triggered the rebuild that surfaced this.

**Fix applied:** Prepend `git fetch --unshallow 2>/dev/null || true` to the `build` and `build-cf` npm scripts so the clone is converted to full history before VuePress runs. The guard is a harmless no-op on a complete local clone.

**Required follow-up (cannot be done from the repo):** Ensure the Cloudflare Pages project's *Build command* is `npm run build-cf` so the fix takes effect, then trigger a redeploy. After deploy, verify the live contributors/changelog on a multi-author page (e.g. /guides/ssh-guide/) show multiple authors again.

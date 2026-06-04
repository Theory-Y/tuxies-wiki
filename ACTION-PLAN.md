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

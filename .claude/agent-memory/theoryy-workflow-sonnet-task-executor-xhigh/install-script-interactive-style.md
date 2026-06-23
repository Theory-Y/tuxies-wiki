---
name: install-script-interactive-style
description: How the user wants install/setup shell scripts written for this wiki — highly interactive, keyd-setup.sh as the style exemplar
metadata:
  type: feedback
---

For install/setup shell scripts in this repo (e.g. `resources/*/install.sh`), the user wants them **highly interactive**, modelled on the hand-written `resources/key-remapping-with-keyd/keyd-setup.sh`:

- A `### Colours ###` ANSI block (INFO/EMPH/PROMPT/SUCCESS/WARNING/ERROR/DIM/NC) and `###`-banner section headers whose top/bottom `#` rows exactly match the title line's character width.
- A reusable `[y/n]` gate before each phase so the user can skip any part independently.
- **Inspect before install:** show each dotfile's contents, then offer to open it in `"${EDITOR:-nano}"` (display the editor *basename* — e.g. "Use nano" — not the full `/usr/bin/nano` path) so the user can customise it before it is copied.
- Any `sudo`/system change must be **opt-in, fully disclosed before running, and `[y/n]`-gated**; skip such phases under `-y`/non-TTY.

**Why:** the user values transparency and control over what lands on their system, plus a beginner-friendly walkthrough.
**How to apply:** when writing or revising a setup script, match this style; reuse `keyd-setup.sh` and `resources/logitech-linux-setup/install.sh` as references. Relates to [[finalise-then-commit-discipline]].

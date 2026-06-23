---
name: render-check-is-not-correctness
description: Recurring weak spot in this wiki's plans — "render check (npm run build) passes" is used as the done-condition but only proves containers PARSE, never that content is correct
metadata:
  type: feedback
---

Recurring plan weakness: plans lean on `npm run build` / `npm run dev` ("render check") as the verification step. This only proves markdown containers and colon-nesting **parse**. It does NOT verify: install commands work, package names exist, copied snippets match their source verbatim, or internal links resolve (no deadlink plugin is configured).

**Why:** observed across the logitech, terminal-quick-append, and rime plans. Concrete proof the risk is real: the terminal-customisation-bash guide already shipped a **PS1 drift** (preview block line ~89 `setaf 26/32/38/44/26/75` vs canonical instruction line ~161 `setaf 56/56/92/128/128/200`) — a transcription error that a render check passed silently.

**How to apply:** when a plan's only verification is a render/build check but its done-condition asserts *correctness* (verbatim-match, working commands, valid package names), flag it and require a distinct correctness check:
- copied snippets → explicit char-for-char diff against the canonical source site
- install commands / package names → confirm against packages.debian.org / archlinux.org+AUR before publish
The rime plan (`action-plans/rime-input-method-guide.md`) does this correctly — it separates render vs correctness and sources a hard pre-publish gate. Use it as the exemplar. Related: [[deploy-trigger-and-publish-gates]].

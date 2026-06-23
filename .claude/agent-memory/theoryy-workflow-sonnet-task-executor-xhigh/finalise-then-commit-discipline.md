---
name: finalise-then-commit-discipline
description: The user's review/commit workflow — nothing is "done" (ROADMAP check-offs, commits) until they explicitly finalise
metadata:
  type: feedback
---

The user runs a strict review gate: **do not mark work "done" until they explicitly say "finalise."** That means don't check off `ROADMAP.md` items, don't move them to **Completed**, and don't declare victory until told. They review (often rendering/testing themselves) and stage/commit work on their own; **commits and pushes stay theirs** unless they ask you to stage. When dispatched as an executor, this is why briefs say "do NOT edit ROADMAP / do NOT mark done" — respect that.

**Why:** they verify each change before accepting it and keep control of git history.
**How to apply:** complete and verify the work, present it for review, and wait for an explicit "finalise" before running workflow step 7 (ROADMAP check-offs + change-log + folder READMEs). Don't `git commit`/`push` unless asked. Relates to [[install-script-interactive-style]].

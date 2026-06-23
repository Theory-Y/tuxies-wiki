# Action Plan — Terminal Customisation (Bash): master quick append

**Status:** PLANNED (approved scope; awaiting council → execution)
**Deliverable:** A single unified **master quick append** near the top of
`docs/guides/terminal-customisation-bash.md` that consolidates every `.bashrc` config/command the guide
covers, so a reader can copy everything at once — mirroring the Ghostty guide's master quick append.
**Definition of done:** One `::::details Master quick append` block sits right after the guide's intro
(before/around the "Back up current `.bashrc`" section), containing a single `:::code-tabs` `.bashrc` block
with: `fastfetch` autorun, the canonical `PS1` prompt, the `fzf` aliases, `zoxide` init, the `eza` alias
set, and the `yazi` `y()` cd-on-exit wrapper. Colon-nesting is valid; `npm run build` parses; each snippet
matches its canonical in-guide instruction verbatim.

## What to consolidate (pull from canonical instruction sites, NOT the preview blocks)
The guide already has two section-scoped "Quick append & preview" blocks; the master append unifies their
*content* into one top-level block:
- `fastfetch` autorun — `fastfetch` line (§ Aesthetic Changes, line ~136).
- `PS1` prompt — use the canonical value from the **instruction step at line ~161**
  (`setaf 56/56/92/128/128/200`), **not** the divergent preview value at line ~89. ⚠ There is an existing
  inconsistency between those two; the master append follows the instruction step. Flag the mismatch in the
  handoff so it can be reconciled separately (out of scope here).
- `fzf` aliases — `cmd` / `zh` (line ~187-189).
- `zoxide` — `eval "$(zoxide init bash)"` (line ~192).
- `eza` aliases — the full `lsd*` / `lst*` / `lsda*` / `lsta*` set (line ~194-214).
- `yazi` `y()` cd-on-exit wrapper — the function (line ~216-223).

## Decisions locked
- **Placement:** master append goes after the intro, per the guidelines' Quick-append definition
  ("right after a guide's intro that consolidates every config or command the guide covers").
- **Existing per-section quick-appends stay** — they carry screenshots/previews and serve as section-local
  recaps. The master append is the single copy-everything block; do not delete the section ones.
- Use `:::code-tabs` (single `.bashrc` file), matching the guide's existing append style and the Ghostty
  precedent. Lead with one line: paste into `~/.bashrc`; each option is explained in the sections below.

> **Council note (2026-06-22, baseline panel):** the alternatives lens observed that the §Terminal-programs
> "Quick append & preview" block already carries the full `fzf`/`zoxide`/`eza`/`yazi` payload, so adding the
> master append creates a **third** copyable copy of those snippets (master + two section previews). We are
> keeping the plan **additive** because the roadmap item literally says "add a master quick append" and the
> scope lens praised the section appends as legitimate section-local recaps. Flagging the redundancy here so
> the user can decide later whether to trim the section blocks to preview-only — **out of scope for this
> pass.** (Minor accuracy note: the Ghostty guide ships *two* master appends — generic + GNOME — not one;
> for this single-config guide one master append is correct.)

## Steps

| # | Step | Owner | Done-condition | Deps |
|---|------|-------|----------------|------|
| 1 | Insert the `::::details Master quick append` block after the intro, consolidating all six snippets above into one `.bashrc` `:::code-tabs` block, snippets copied **verbatim** from their canonical instruction sites, organised with the same `#### section ####` comment headers the guide already uses. Self-check before finishing: (a) **char-for-char diff** each of the six snippets against its canonical site — render alone cannot catch a mistyped alias, and this file already shipped a PS1 drift; (b) colon-nesting valid (outer `::::details` at 4 > inner `:::code-tabs` at 3); (c) the two existing section quick-appends left untouched; (d) `npm run build` (or `dev`) parses. | `sonnet-task-executor-medium` | One unified master append near the top with all six configs verbatim-matching their canonical sites; nesting valid; section appends intact; build parses | — |

## Sequencing
Single step, single file, one executor — verification (nesting, the char-for-char snippet diff, build) is
folded into the done-condition rather than dispatched as separate steps. No parallelism.

## Risk & reversibility
Low / fully reversible — one additive block in one guide. Main hazards: (a) colon-nesting breaking render
(mitigated by step 2 + the build check), (b) copying the wrong/divergent `PS1` (mitigated by the explicit
"use line ~161, not line ~89" instruction). `graphify update` skipped — CLI unavailable (note in ROADMAP).

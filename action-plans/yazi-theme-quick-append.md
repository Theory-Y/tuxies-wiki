# Action Plan — Yazi theme reskin + master quick append

**Status:** FINALISED 2026-06-22 (user-approved). Ready to dispatch on user's go. Per user: do NOT check off the ROADMAP item until they finalise the rendered result.
**Deliverable:** Two targeted edits to `docs/guides/yazi.md`:
  1. Reskin the `[which]` popup: background `#2e383c` → `#1e2228`, and shift the other Everforest-tinted accents to neutral greys — keep only the gold `cand` accent.
  2. Add a **master quick append** `::::details` block consolidating all config/command snippets the guide covers.
**Scope:** `docs/guides/yazi.md` only — no new files, no navbar/config changes.

---

## 0. Pre-flight (verify before writing)

- Re-read `CLAUDE.md` and `docs/notes/about/contributions/guidelines.md` at execution time.
- Confirm the user's chosen neutral hex (see Open Questions) before touching `theme.toml`.
- No install-command correctness risk here — this edit is config/style only.

---

## 1. Target & insertion points

**Change 1 — theme.toml neutral reskin**

File: `docs/guides/yazi.md`, lines 178–198 (the `@tab ~/.config/yazi/theme.toml` code block inside `::::details Custom config files`).

Current Everforest values to change:

| Key | Current value | Action |
|-----|---------------|--------|
| `mask.bg` | `"#2e383c"` (Everforest bg2) | Replace with neutral hex (TBC) |
| `cand.fg` | `"#dbbc7f"` (Everforest yellow / gold) | **Keep unchanged** |
| `rest.fg` | `"#a6b0a0"` (Everforest muted green-grey) | Review — may stay or shift to neutral grey |
| `desc.fg` | `"#d3c6aa"` (Everforest foreground) | Review — may stay or shift to neutral off-white |
| `separator_style.fg` | `"#7a8478"` (Everforest separator) | Review — may stay or shift to neutral grey |

The comment on line 182–183 (`# Palette = Everforest Dark Hard, matching the Ghostty terminal theme`) must also be updated to reflect the new neutral palette.

The prose reference on line 92 (`The \`theme.toml\` uses the \`Everforest Dark Hard\` theme (also used in the Ghostty Terminal guide)`) must be updated — either remove the Everforest attribution or note it is now a neutral theme.

**Change 2 — master quick append block**

Insertion point: after the frontmatter/before `## **Installation**`, i.e. insert a new `::::details Quick append` block at **line 14** (current first content line), pushing `## **Installation**` down.

Per guidelines (§ Quick append): placed right after the intro — since this guide has no standalone intro callout, position it as the very first content block before `## **Installation**`.

---

## 2. Change outline

### 2a. Neutral reskin

Replace `mask.bg` with the confirmed neutral hex. Update the comment header in the code block. Update the prose description at line 92. Leave `cand.fg = "#dbbc7f"` (gold) untouched. Adjust `rest.fg`, `desc.fg`, `separator_style.fg` to neutral-palette equivalents if they currently carry Everforest-green tints (executor judgement call, flag any uncertainty).

### 2b. Master quick append — consolidation inventory

The guide currently contains these config/command snippets (all must appear in the quick append):

| # | File / context | Section in guide | Lines |
|---|----------------|-----------------|-------|
| 1 | `~/.config/yazi/keymap.toml` — `g`-prefix nav shortcuts | Custom navigation shortcuts → `::::details Custom config files` | 119–176 |
| 2 | `~/.config/yazi/theme.toml` — `[which]` popup style | Same `::::details` block | 178–198 |
| 3 | `~/.config/yazi/yazi.toml` — `[mgr]` ratio + `[preview]` resolution | Resizing image previews | 244–255 |
| 4 | `~/.bashrc` — `y` shell wrapper function | The `y` shell wrapper (cd-on-exit) | 211–223 |

Structure of the master quick append block (per guidelines quick-append convention):

```
::::details Quick append

:::note
You can also download ready-made files … (existing note, line 16-19, move/mirror here)
:::

:::code-tabs

@tab ~/.config/yazi/keymap.toml
<full keymap.toml snippet>

@tab ~/.config/yazi/theme.toml
<full theme.toml snippet — with updated neutral bg>

@tab ~/.config/yazi/yazi.toml
<full yazi.toml snippet>

@tab ~/.bashrc
<full y() wrapper snippet>

:::

::::
```

The existing `:::note Quick append` block at lines 16–19 (a plain note, not a proper quick-append container) should be removed after its content is incorporated into the master quick append block above.

---

## 3. House-style checklist

- Quick append placed as first content block, using `::::details Quick append` with `:::code-tabs` inside (guidelines § Quick append, § Code tabs).
- Colon nesting: outer `::::details` (4 colons) wraps inner `:::code-tabs` (3 colons) — correct per the count-from-inside-out rule (guidelines § Code Structure).
- The `:::note` inside the quick append sits at 3 colons; if it is nested inside the `::::details`, bump nesting to ensure outer always has more colons.
- Backtick all file paths, program names, and config keys; no bold + highlight combined (guidelines § Code block & inline code).
- Updated comment in `theme.toml` code block must use `# Neutral dark palette` or similar — remove the Everforest attribution.
- Prose emphasis via `==highlight==` not bold (guidelines § Highlighting).
- GB English; "we" voice.

---

## 4. Validation

- **Render check:** `npm run build` (or `npm run dev`) — confirm the new `::::details` / `:::code-tabs` / `:::note` nesting parses without VuePress container errors.
- **Visual spot-check:** Open the guide in dev preview; expand the Quick append block and verify all four tabs render and the `theme.toml` neutral colour looks correct in context.
- No install-command correctness gate required (this is config-only).

---

## 5. Suggested delegation

**Single `sonnet-task-executor-medium`** is sufficient — this is a contained two-part edit on one file with no new files, no distro-specific fact-checking, and no novel structural decisions. Brief = this plan + user-confirmed neutral hex.

---

## Decisions (finalised 2026-06-22 — user-approved)

1. **`mask` bg** → **`#1e2228`** (neutral near-black, no green tint). ✅ approved.
2. **Full de-Everforest** — user chose the grey option (this OVERRIDES the earlier "leave them" recommendation). Shift the tinted accents to neutral greys, keeping ONLY the gold accent:
   - `rest` fg `#a6b0a0` → **`#8a8f98`** (neutral grey)
   - `desc` fg `#d3c6aa` → **`#c5c8d0`** (neutral off-white grey)
   - `separator_style` fg `#7a8478` → **`#6b7280`** (neutral slate — the plan named no specific value; executor may pick a closer neutral if this reads off, but stay grey with no green tint)
   - `cand` fg `#dbbc7f` → **KEEP** (gold accent).
3. **Quick-append stub** (the `::::note` near line 16) → **absorb & remove**; fold its content into the master Quick append. ✅ approved.

**Anchor note for the executor:** the real TOML uses inline-table syntax — `mask = { bg = "#2e383c" }` (≈line 188), `cand = { fg = "#dbbc7f", bold = true }` (≈line 190), under `[which]` (≈line 185) — match that form, NOT dotted `mask.bg`. Also update the `# Palette = Everforest Dark…` comment (≈line 182) and the prose Everforest attribution (≈line 92) to a neutral-palette description.

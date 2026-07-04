# Override cleanup — knock down easy items first (2026-07-03)

Source: `OVERRIDE.md` (6 items). Strategy: execute the 4 bounded items now (player-coach),
move the 2 heavy/vague items to `ROADMAP.md` Open, then delete `OVERRIDE.md`.

## Steps

1. **Add Fresh Editor to editors-choice** — owner: sonnet-high · easy
   - File: `docs/notes/linux-apps/editors-choice.md`. Web-verify what "Fresh Editor" is +
     official link before adding; follow guidelines entry format. Flag if ambiguous.
   - Done: entry added with verified link, matches surrounding format.

2. **Focus changer extension in aiers-gnome** — owner: sonnet-high · easy
   - File: `docs/guides/aiers-gnome.md`, under `### Others` (~line 187). Web-verify the
     extension (extensions.gnome.org), note desktop use-case.
   - Done: entry added per Extension & module entry format (link → :::info → :::tip → media).

3. **Ghostty GNOME shortcut simplification** — owner: sonnet-high · medium
   - File: `docs/guides/ghostty-terminal.md`. Replace the "rebind splits for GNOME" approach
     (GNOME master quick-append block ~43–65 + `### Focus-Split Up/Down on GNOME` ~226–245)
     with: disable GNOME's conflicting `Ctrl`+`Alt`+`Up`/`Down` workspace shortcuts
     (set to nothing in GNOME Settings → Keyboard; gsettings alternative in details).
     Collapses back to one master quick-append.
   - Done: single quick-append, GNOME section teaches disabling shortcuts, no alt+shift rebinds left.

4. **New keyd settings → wiki + script** — owner: main thread (player) · medium
   - Move root `default.conf` → `resources/key-remapping-with-keyd/default.conf`; fix stale
     comment (body uses `[shift] capslock = capslock`, not double-shift). Sync guide example
     block + mapping table + note the `[shift]` layer section; sync `keyd-setup.sh` heredoc.
   - Done: conf, guide, script all show identical new mappings.

5. **Defer heavy items to ROADMAP** — owner: main thread · easy
   - "Revise the app lists" + "slim down app series via AI council redesign" → ROADMAP Open
     (needs a dedicated /council session).

6. **Bookkeeping (workflow step 7)** — owner: main thread
   - ROADMAP: check off / log; delete `OVERRIDE.md`; `graphify update .`;
     `subdir-readme-author` for `resources/key-remapping-with-keyd/`.
   - No commits — user finalises.

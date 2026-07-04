# App-lists restructure (2026-07-04)

Source: ROADMAP Open items "Revise the app lists" + "Slim down app series", specified by the
maintainer's notepad.md and live Q&A. Decisions: popular.md STAYS; gnomie.md removed
(redundant with gnome.md except SaveDesktop); new "Dev (Computer Nerd) Tools" series.

## Steps

1. **OBS Studio → creative-software.md** — owner: main thread — DONE
   (entry + v4l2loopback subsection moved verbatim out of editors-choice.md).
2. **dconf CLI → gsettings CLI sweep** — owner: sonnet-high — in flight
   Files: gnome.md (owns file incl. gnomie-link removal), aiers-gnome.md,
   better-text-rendering-gnome-hi-dpi.md, guidelines.md. Schema/key names verified read-only
   via local gsettings. Done: no dconf CLI commands left in main flows.
3. **Create dev-tools.md series** — owner: sonnet-high — in flight
   Move Fresh + Waydroid (from editors-choice) + SaveDesktop (from gnomie); add fastfetch,
   fzf, zoxide, eza, yazi entries linking the terminal-customisation-bash tutorial as the
   curated walkthrough; delete gnomie.md; navbar swap (gnomie out, dev-tools in); fix
   inbound gnomie links (except gnome.md); update linux-apps README.
4. **Verify + bookkeeping** — owner: main thread
   Cross-check both agents' outputs (leftover gnomie refs, dead anchors, navbar sanity,
   npm build if cheap); ROADMAP check-offs + change log; graphify update. No commits.

## Also resolved this session
- Ghostty GNOME "Navigation" label item: verified locally (gnome-control-center 50.1) —
  label correct but entries hidden="true", GUI path impossible; maintainer already rewrote
  the section gsettings-first. Item closes.

# Roadmap

Active and planned work for the wiki. Resolved audit history is collapsed at the
bottom — see **Completed** for the record.

Legend: 🔴 dangerous / data-loss · 🟠 broken command · 🟡 missing step / gap · 🔵 style

---

## Open

### TheoryY fastfetch `config.jsonc` · ⚑ active override

- [x] Created the TheoryY-branded config at `resources/terminal-customisation-bash/config.jsonc`
      (THEORY logo + gold accents, centered Hardware/Software/Uptime section headers — no
      box corners, so long lines like Packages don't overflow a border) and linked it as a
      download from the **Autorun `fastfetch`** step of
      `docs/guides/terminal-customisation-bash.md`. (Config is 158 lines — linked, not inlined
      as a code-tab, matching the repo's `resources/` download convention.)
- [ ] 🟡 Refresh the guide screenshot
      `docs/.vuepress/public/assets/terminal-customisation-bash/fastfetch.png` — it still shows
      the **default Fedora** output, not the branded config. Last open piece of this override;
      clear `OVERRIDE.md` once done.

### Cloudflare Pages — contributors/changelog redeploy

- [ ] 🟡 Set the Cloudflare Pages project **Build command** to `npm run build-cf`, then
      redeploy. The `git fetch --unshallow` fix is already in `package.json`; it only takes
      effect once CF uses `build-cf`. Cannot be done from the repo (dashboard setting).
      After deploy, verify a multi-author page (e.g. `/guides/ssh-guide/`) shows multiple
      contributors and a full changelog again. (Regression diagnosed 2026-06-05.)

---

## Planned — testing iterations (do NOT publish yet)

### Firefox `user.js` guide — defer touchpad scrolling to the Gnome guide

**File:** `docs/guides/firefox-userjs.md` · **Status:** testing iteration, unpublished.

Demote the Firefox guide's **Trackpad scrolling** prefs in favour of the system-level
touchpad fix already on the External Resources page (`/guides/external-resources/`).

- [x] Edits landed in repo 2026-06-10 — three touchpad-specific prefs commented out as an
      optional choice, `apz.fling_friction` retuned `"0.005"` → `"0.004"`, and a `:::tip`
      added pointing to the External Resources fix. (Full pref names in git / the file.)
- [ ] 🟡 **Do NOT publish** — testing iteration only; hold from deploy until reviewed.

---

## Completed

- **Extension/module entry format standardised (2026-06-20)** — defined a fixed display
  order for extension/app entries in collapse modules: `link _(notes)_` → `:::info`
  description → `:::tip` config → picture/video **last**, so links and configs always sit
  above the demonstration (readers were missing custom configs that tall screenshots pushed
  below the fold). Reformatted both collapse sections of `docs/guides/aiers-gnome.md`
  (dropped the stray per-item `card` on AppIndicator; moved configs above images for Just
  Perfection, Alphabetical App Grid, Dash to Dock, Show Desktop Plus; normalised
  `::: info`→`:::info` and `My settings:`→`My settings`; wrapped the Show Desktop Plus video
  in `:::demo-wrapper`). Codified it in a new **Extension & module entries** section of
  `docs/notes/about/contributions/guidelines.md` (+ a pointer from **Details & collapse**).
  Other guides (`logitech-linux-setup`, `terminal-customisation-bash`, `firefox-userjs`,
  `ghostty-terminal`, `yazi`) audited — already compliant (configs precede screenshots within
  their steps/quick-appends). Also copied `blur-my-shell-demonstration.png` →
  `just-perfection-demonstration.png` (the shot shows both extensions' effects; duplicated
  under the convention name to avoid future confusion) and repointed the Just Perfection
  image. `graphify update .` not run — CLI unavailable in this environment.
- **Logitech setup install script (2026-06-19)** — added
  `resources/logitech-linux-setup/install.sh`: quick-installs the Solaar
  (`rules.yaml`) and Kando (`config.json` + `menus.json`) presets, auto-detecting
  Flatpak vs native config paths (`--flatpak`/`--native` to force), timestamped
  backups before overwrite, idempotent (skips unchanged files), and warns to quit
  Solaar first (it rewrites `rules.yaml`; Kando hot-reloads). Created the folder's
  first `README.md`, and added a **Quick append** to
  `docs/guides/logitech-linux-setup.md` pointing readers at the installer.
  `graphify update .` not run — CLI unavailable in this environment.
- **Guide audit (pass 1)** — all guides reviewed for malpractice; 🔴/🟠/🟡/🔵 fixes landed
  across `editors-choice.md`, `terminal-customisation-bash.md`, `rb-14-2023-fedora.md`,
  `ssh-guide.md`, `key-remapping-with-keyd.md`, `microsoft-edge-setup.md`, and the
  error-dense `arch.md`. `graphify update .` run after landing.
- **Guide audit (pass 2, 2026-06-04)** — full re-read incl. `notes/`. Fixes in
  `rb-14-2023-fedora.md` (`/usr/bin/` → `/usr/local/bin/`), `editors-choice.md`
  (Bitwarden links/description, Inkscape/Vesktop syntax), `arch.md` (missing `sudo`),
  `vuepress-guide.md`, `qemu-kvm.md`, `ssh-guide.md` (Ed25519, `ssh-copy-id -i`),
  `aiers-gnome.md`, `ctf-second-brain.md`, `terminal-customisation-bash.md`.
  `graphify update .` run after.
- **Contributors/changelog regression (2026-06-05)** — root-caused to Cloudflare Pages
  shallow clone (depth 1) collapsing git-derived metadata to one commit. Fix: prepend
  `git fetch --unshallow 2>/dev/null || true` to `build` / `build-cf` scripts. Repo side
  done; deploy side tracked under **Open** above.
- **aier's Gnome → checklist hub (2026-06-19)** — appended a "More resources..." `:::info`
  callout at the bottom of `aiers-gnome.md` linking every item on aier's Fedora checklist
  (`docs/.vuepress/public/reference-docs/aiers-fedora-checklist.md`), grouped as on the
  checklist. "Pre-partition for dual boot" → Fedora guide (no dedicated partitioning page);
  "Fluent icons & cursor" omitted — no coverage anywhere in the wiki (candidate to also
  remove from the checklist source). `graphify update .` could **not** be run — the
  `graphify` CLI is unavailable in this environment; run it where installed to refresh
  `graphify-out/`.

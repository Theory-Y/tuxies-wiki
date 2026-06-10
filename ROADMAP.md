# Roadmap

Active and planned work for the wiki. Resolved audit history is collapsed at the
bottom — see **Completed** for the record.

Legend: 🔴 dangerous / data-loss · 🟠 broken command · 🟡 missing step / gap · 🔵 style

---

## Open

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

We now have a Gnome touchpad scrolling guide (`notes/linux-guides/gnome.md`) covering
touchpad config at the system level. The Firefox guide's **Trackpad scrolling** section
duplicates that, so demote those prefs to an optional alternative.

- [ ] In the **Trackpad scrolling** section (and the matching lines in the **Preview**
      `user.js` block), comment out the three touchpad-specific prefs as an optional choice:
  - `apz.gtk.pangesture.delta_mode`
  - `apz.gtk.pangesture.pixel_delta_mode_multiplier`
  - `apz.overscroll.enabled`
- [ ] Keep `apz.fling_friction` **active**, but change its value `"0.005"` → `"0.004"`.
- [ ] Add a short note pointing readers to the Gnome touchpad scrolling guide as the
      preferred system-level approach.
- [ ] Do not publish — this is a testing iteration only.

---

## Completed

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

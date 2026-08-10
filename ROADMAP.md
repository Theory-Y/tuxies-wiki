# Roadmap

Active and planned work for the wiki. Resolved audit history is collapsed at the
bottom — see **Completed** for the record.

Legend: 🔴 dangerous / data-loss · 🟠 broken command · 🟡 missing step / gap · 🔵 style

---

## Open


- 🔵 **Hardware video acceleration — Intel tab unverified** — AMD and NVIDIA tabs in `fedora.md`
  verified on Fedora 44 by probing VA-API through `libva`. AMD (Radeon 890M), before *and* after:
  stock Mesa exposes only JPEG, VP9 and AV1 — no H.264, no HEVC; `mesa-va-drivers-freeworld` adds
  H.264 (all profiles) + HEVC Main/Main10 with decode *and* encode (JPEG decode drops off). NVIDIA
  (RTX 4060, driver 610.43.03): `libva-nvidia-driver` yields H.264 + HEVC (Main/10/12/444) and needs
  no env vars — libva autodetects it and picks the direct NVDEC backend. Intel
  (`intel-media-driver`) still follows RPM Fusion's documentation untested — no Intel graphics to
  hand. Confirm with `vainfo` before/after (`libva-utils`), checking H.264/HEVC appear as `VLD`.

  On a hybrid laptop the dGPU must be unblocked for its driver to be reachable at all — Cardwire in
  `integrated` mode hides the NVIDIA render node entirely. Possible guide note if it trips others up.

- 🟡 **SEO: post-deploy manual steps** — sitemap already submitted in GSC (Success, 46 pages,
  2026-07-24). After the next Cloudflare deploy: use URL Inspection on the homepage and hit
  **Request indexing** so the site (not the GitHub ROADMAP blob) becomes the top result — GitHub
  currently outranks it only because the site is freshly indexed; expect it to flip within days
  to a few weeks. Config-side SEO done (see Completed).

- 🔵 **`asusctl.md` maintainer review in progress** — marked `draft: true`. Maintainer reviewed
  through the **"One power manager at a time"** `:::warning` (end of Install section); a
  `:::danger Reviewed up to this point.` marker sits at that line. Everything below it (Platform
  Profiles onward) is still unreviewed. Remaining accuracy note: the **"Power profiles vs. your
  desktop's toggle"** final section still says the desktop switch "routes through `asusctl`" —
  mechanically it routes through `power-profiles-daemon` and `asusd` syncs to it. Drop `draft` +
  the marker once review completes. Maintainer pushes manually.

---

## Deferred

- 🔵 **Image backfill — `asusctl.md` + `gnome-further-customisation.md`** — both guides ship/exist
  text-first and want screenshots added later (images go last per the entry-order rule).
  - `docs/guides/asusctl.md`: ROG Control Center **System tab** shot (EPP-link toggle + "Throttle
    Policy for power state" AC/battery controls) is the priority; profile-dropdown + battery-tab shots
    are nice-to-have. Drop into `docs/.vuepress/public/assets/asusctl/`, ref `/assets/asusctl/<name>.png`.
    Look for `<!-- TODO image: … -->` markers in the guide.
  - `docs/guides/gnome-further-customisation.md`: sweep for extension entries missing a demo image and
    backfill from `docs/.vuepress/public/assets/gnome-further-customisation/`.

- 🟡 **MosaicWM extension** (ext 8502, `CleoMenezesJr/MosaicWM`) — mosaic/tiling WM for GNOME.
  Currently **unstable** and needs GNOME Shell 50+; do **not** add to
  `gnome-further-customisation.md` yet. **Re-evaluate stability from 2026-10-16 for a week
  straight** — if stable by then, add it under the **Others** collapse (Tiling Shell neighbour)
  with the standard link → `:::info` entry.

---

## Completed

- **Kitty guide; default terminal recommendation Ghostty → Kitty (2026-08-10)** — new
  `docs/guides/kitty-terminal.md` (`/guides/kitty-terminal/`) mirrors the Ghostty guide's configs in
  `kitty.conf` terms: quick append, distro install tabs (official repos everywhere — no Terra),
  `kitten themes` picker, `background_opacity`/`background_blur` (+ Blur my Shell warning),
  `remember_window_size no` + `initial_window_width/height` in cells, shortcut list, GNOME launcher
  keybind. Reason for the switch: smooth touchpad scrolling. Recommendation swaps:
  `aiers-fedora.md` Dev-stuff link and `yazi.md` image-preview tip now point at the Kitty guide.
  Ghostty guides kept as-is.

- **Fedora guide: codecs, RPM Fusion, firmware (2026-08-02)** — highest-value gaps from TechHut's
  Fedora 44 post-install guide folded in. `## Terra repository` became `## Other Repositories`
  holding `### RPM Fusion` + `### Terra` (four dependent `#terra-repository` anchors repointed to
  `#terra` across `gpu.md`, `asusctl.md`, `ghostty-terminal.md`, `yazi.md`; `gpu.md` now links here
  instead of repeating the RPM Fusion command). New `## Multimedia Codecs` (`ffmpeg` swap +
  `multimedia`/`core` group upgrades) with a `### Hardware video acceleration` vendor-tab subsection,
  new firmware `fwupdmgr` step with a Gnome Software screenshot, and a `## Flatpak` pointer.
  Deliberately skipped: `dnf.conf` tweaks (defaults checked — 3 parallel downloads; `defaultyes`
  removes a confirmation prompt, wrong for a beginner guide), plus Docker/SSH/NetBird/SMB/OBS
  (dev-specific) and GNOME extensions (already covered). Intel acceleration tab unverified — see
  **Open**.

- **Terminal-customisation guide consolidated; fish folded in (2026-07-27)** — separate fish guide
  scrapped; single bash-centric `terminal-customisation-bash.md` remains. Two master quick appends —
  "(Bash)" and "(Fish)" details blocks (nested shell/distro tabs rendered flat, so split) — fish one
  adds distro-tabbed quick install + `chsh -s $(which fish)` and an autoload-style config split
  across code-tabs — `config.fish` (interactive-only block) + `functions/fish_prompt.fish` (hex
  `set_color` equivalents of the tput-256 PS1 colours) + `functions/y.fish` — prefaced by
  `mkdir -p ~/.config/fish/functions`. New `edit-bash`/`edit-fish` `$EDITOR` aliases. fzf aliases renamed
  `cmd`→`show-commands`, `zh`→`search-history` (both shells verified). eza section + aliases removed
  (deprecated in favour of yazi). Demo images consolidated: single `terminal-preview.png` (cropped
  fastfetch + fish prompt screenshot) shown after the intro; `aesthetic-terminal.png`,
  `custom-ps1.png`, `fastfetch.png` deleted. Later renamed shell-agnostic:
  `terminal-customisation.md`, permalink `/guides/terminal-customisation/`, assets folder
  `terminal-customisation/`; inbound links (aiers-fedora, dev-tools, guidelines example, notepad)
  updated; stub page at old permalink links the new one (`article: false`, out of listings).

- **dGPU A/B test done; lab-testing labels lifted (2026-07-26)** — 2h suspend with
  `NVreg_EnableS0ixPowerManagement=1` off (touchpad fix on): 99.88% residency, ~0.9%/h drain vs
  0.79%/h with the fix — dGPU contribution ≈ noise; touchpad storm was the whole drain. Driver
  default `DynamicPowerManagement: 3` (RTD3) already lands the idle card in `D3cold` pre-suspend, so
  the `NVreg_EnableS0ixPowerManagement=1` advice was redundant. Wiki: `gpu.md` sleep section rewritten
  — dGPU sleeps by default, verify via `power_state` (not `nvidia-smi`/`lspci`, they wake the card),
  residency measure + link to ProArt worked example, `Preserve*` freeze warning kept; heading suffix
  dropped so ProArt anchors work. ProArt guide: lab-testing warning + `draft: true` removed, results
  tip touchpad-only numbers. Local `/etc/modprobe.d/nvidia-pm.conf` left commented out.

- **Sleep-drain docs republished after overnight verification (2026-07-26)** — overnight numbers with
  both fixes: 99.97% hw-sleep residency, ~0.8%/h drain (vs 6.8%/h before). `gpu.md` sleep section
  un-hidden and rewritten measure-first (Step 1: `suspend_stats` residency + wakeup-source hunt;
  Step 2: `NVreg_EnableS0ixPowerManagement=1` with honest ~1–1.5%/h impact note, `Preserve*` freeze
  warning kept). New machine guide `docs/guides/proart-p16-2025.md` (`/guides/proart-p16-2025/`):
  touchpad (`ASCF1A01:00`) wakeup-storm udev fix, results, diagnosis `::::details`; cross-links with
  the GPU Guide both ways. dGPU-in-`D0` exact share still unquantified (A/B test not run) — wording
  kept honest about that.

- **asusctl guide: terminal quick append (2026-07-25)** — added a `::::details Quick append` after the
  intro callouts of `asusctl.md` (mirrors gpu.md placement) with Apply/Reset `:::tabs`. Consolidates the
  GUI-focused guide into copy-paste CLI: `systemctl enable --now asusd.service`, per-power-state auto
  switching (`asusctl profile set -a Balanced` / `-b Quiet`), current profile, and `asusctl battery
  limit 80` (fulfils the intro's charge-threshold promise the GUI body never covered). All commands
  verified against local `asusctl --help` (installed on the ProArt P16).

- **GPU guide: overnight sleep-drain fix section (2026-07-25)** — new `gpu.md` H2 documenting the
  NVIDIA `s2idle` battery-drain fix (dGPU stuck in `D0` all night): `/etc/modprobe.d/nvidia-pm.conf`
  with `NVreg_EnableS0ixPowerManagement=1`, plus a warning that `NVreg_PreserveVideoMemoryAllocations=1`
  hard-freezes `s2idle` machines at sleep entry. Includes `mem_sleep` applicability check,
  `suspend_stats` verification, and a technical-why `::::details`. Debugged and verified live on the
  ProArt P16 (98% hardware-sleep residency after fix). **Section since commented out** — upower
  drain comparison showed the dominant leak was a touchpad (`ASCF1A01:00`) wakeup interrupt storm
  (~5.3 of ~6.8%/h); dGPU share unconfirmed pending an A/B test. See Open item.

- **Merged `resources/` into `assets/` — single source of truth (2026-07-21)** — killed the repo-root
  `resources/` tree. Each download bundle's source now lives beside its zip under
  `docs/.vuepress/public/assets/<name>/<name>/` (subfolder), zip rebuilt at
  `assets/<name>/<name>.zip`. Moved: `key-remapping-with-keyd`, `logitech-linux-setup` (folder-rooted
  zips), `terminal-customisation-bash/config.jsonc` → `theoryy-fastfetch-config.zip`,
  `microsoft-edge-setup/HubApps` → `HubApps.zip` (flat-rooted). All 4 zips rebuilt non-recursively and
  verified content-identical to originals (byte-identity not preserved — mtimes differ). Stragglers:
  `ghostty-terminal/keyboard-shortcuts.md` **promoted to a real wiki page** `docs/guides/ghostty-shortcuts.md`
  (permalink `/guides/ghostty-shortcuts/`, frontmatter + `:::info`/`:::tip`); the `ghostty-terminal.md`
  link now points to the internal permalink instead of a GitHub blob (renders in-site, no offsite hop).
  Unreferenced `bash-template.sh` → new `authoring/` (kept out of the served site). Guidelines **Download bundles** section rewritten: canonical source is now the asset
  subfolder, plus a `:::code-tabs` block with the **named-subfolder** zip recipe (target is always
  `<name>/` or a named file inside it, never `.` or the parent — the old zip is structurally impossible
  to sweep in; no exclude-globs). Trade-off accepted: raw source now ships in `dist/` alongside the zip.
  **Source-of-truth inverted** from the 2026-07-13 policy: the build source under `assets/<name>/<name>/`
  is now canonical for every file; a guide's inline block is a mirror to update after editing the source
  (previously the guide-inline copy was canonical).

- **Aier's Fedora — Gaze custom-profile workaround retired (2026-08-08)** — upstream Gaze now ships
  `pam_gaze_grosshack.so` in its stock `authselect` profile (`with-face-simultaneous`), fixing the
  GDM keyring gap. `aiers-fedora.md`: `:::warning` → `:::note` (historical), both custom-profile
  tabs replaced by one step — `sudo authselect select gaze with-face-simultaneous
  with-silent-lastlog --force`. Verified live on Fedora 44, gaze 0.2.9, `gaze doctor` 17/17.

- **Aier's Fedora blog + Gaze fix (2026-07-21)** — new `docs/guides/aiers-fedora.md`
  (title `Aier's Fedora`, permalink `/guides/aiers-fedora/`, tags Beginner/Fedora/Gnome, `sticky: 6`,
  first-person). Personal hub: migrated the **"More resources" full-setup checklist** out of the bottom
  of `gnome-further-customisation.md` (which now just links here), plus a hypersimplified
  **Gaze face-unlock-without-breaking-the-keyring** fix — `:::warning` on the login-screen/keyring gap
  (dated 2026-07-21) and a `::::details` → `:::steps` manual-repo install using a custom authselect
  profile with `pam_gaze` stripped from `password-auth`. Kept out of `external-resources.md` per
  maintainer preference (that file was reverted to its plain list).

- **ASUS Control guide — `asusctl` + ROG Control Center (2026-07-18)** — new `docs/guides/asusctl.md`
  (title `ASUS Laptop Control (asusctl)`, permalink `/guides/asusctl/`, tags
  Intermediate/asusctl/Power/Laptop), auto-listed on `/guides/`. ==Beginner / GUI-first==, text-first
  (no images). Sections: install `:::tabs` (Fedora Terra → cross-linked `fedora.md#terra-repository`;
  Debian/Ubuntu honest build-from-source `:::warning` + link to `OpenGamingCollective/asusctl` README,
  no inline dep dump; Arch `extra` `asusctl` + AUR `rog-control-center` with a g14-repo `:::tip`), all
  enabling `asusd.service` + the `power-profiles-daemon` swap `:::warning`; Platform Profile / Throttle
  Policy dial (Quiet/Balanced/Performance table + GUI dropdown, CLI kept to an `asusctl profile --help`
  pointer); EPP + the **linked-EPP** toggle (sysfs detail in `::::details`); the payoff
  "Throttle Policy for power state" AC/battery auto-switch `:::steps`; verify (`asusctl profile -p`,
  `platform_profile` sysfs, unplug test, `journalctl -u asusd -f` in `::::details`); the ppd
  shared-sysfs coexistence section; and an ==incredibly brief== tiling-WM note on **Dank ASUS Control
  Center** (Shazzaam, `dms plugins install dankAsusControlCenter`) + `pseudofractal/AsusControl`
  alternative. Four `<!-- TODO image: … -->` markers left for the Deferred image-backfill item.
  Mirrors the GPU-guide structure. plan: `action-plans/asusctl-guide.md`. Production build passes
  (45 pages, no dead links).

- **SEO round 2 — favicons, canonical, OG image, JSON-LD, robots (2026-07-25)** — replaced the
  hotlinked theme-plume favicon with local ones generated from `tux.png` (`favicon-32x32.png`,
  `favicon-96x96.png`, `apple-touch-icon.png` in `docs/.vuepress/public/`), added a 1200×630
  `og-image.png` wired as the SEO plugin's `fallBackImage`, per-page `<link rel="canonical">` via
  the seo plugin's `canonical` option, a `WebSite` JSON-LD block in `head`, a `robots.txt` in
  `public/` carrying the `Sitemap:` line, and GitHub repo topics (linux, wiki, documentation, …).

- **SEO config — hostname + sitemap + meta (2026-07-24)** — set
  `hostname: "https://tuxies-wiki.theoryy.dev"` in `docs/.vuepress/config.ts` (activates plume's
  dormant sitemap + SEO plugins → generates `sitemap.xml` + `robots.txt`), rewrote the site
  `description` from the title-duplicate `"Tuxie's Wiki"` to keyword-rich Linux copy, and added a
  homepage `title` + `description` frontmatter block to `docs/README.md` (own `<title>`, meta
  description, OG tags). Build-verified: 47-URL sitemap with canonical homepage, robots referencing
  the sitemap, populated homepage `<title>`/`meta`/`og:*`. Remaining manual step (Google Search
  Console submit + index request) tracked in **Open**.

- **Older history (through 2026-07-16), compressed** —
  - fastfetch config re-themed: THEORY ASCII logo → Tux mascot, gold accents → steel blue (#4A90D9);
    layout centring, column-width and ESC-byte build-script fixes; doc blurb synced (2026-07-16).
  - OVERRIDE GNOME-extensions batch: unstarred 4 entries, added Lilypad (top-bar organiser) + Stage
    Manager (ext 9528); Dash-to-Dock show-dock shortcut moved `<Super>q`→`<Super>w` (Close-window
    collision); MosaicWM parked in **Deferred** (unstable, GNOME 50+) (2026-07-16).
  - GPU guide created (`/guides/gpu/`): AMD-vs-NVIDIA driver tabs + **Cardwire** eBPF-LSM
    (mode table, `battery-auto-switch`), later added the `experimental-nvidia-block` toggle; all
    commands verified upstream (2026-07-13/14).
  - Same-origin downloads: every bundle routed through `/assets/*.zip`, guide-inline copy set as
    canonical source-of-truth, keyd/logitech drift reconciled + zips rebuilt byte-identical; Discord
    content split into its own `/guides/discord-vesktop/`; Battery Health Charging + Copyous-deps
    extension entries added (2026-07-13). *(source-of-truth later re-inverted — see 2026-07-21 entry.)*
  - OVERRIDE batch: blue-PS1 code/screenshot match, repo-wide GB-English `-ise`/`-our` sweep, new
    **Terra repository** section in `fedora.md`, `aiers-gnome`→`gnome-further-customisation` rename +
    Auto Power Profile extension (2026-07-12).
  - Pre-07-04: dconf→gsettings sweep (partly reverted — user-installed extension schemas sit outside
    the gsettings path); app-lists restructured (new `dev-tools.md` series, `gnomie.md` removed);
    Ghostty / keyd / Logitech guide overhauls; Cloudflare shallow-clone changelog regression fixed
    (`git fetch --unshallow`); extension entry format standardised in `guidelines.md`; two
    guide-malpractice audit passes.

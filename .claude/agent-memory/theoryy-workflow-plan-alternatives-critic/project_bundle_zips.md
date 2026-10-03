---
name: project-bundle-zips
description: Maintainer keeps hand-built download zips committed beside their source; build-time zips were rejected (2026-10-03)
metadata:
  type: project
---

Download bundles stay as committed zips beside their editable source under `docs/.vuepress/public/assets/<name>/`. Build-time zipping (zip tool in Cloudflare build, zips out of git) was offered and rejected on 2026-10-03.

**Why:** "minimal" philosophy; the corruption bug (HubApps.zip lost `\r` bytes via `* text eol=lf`) is closed by a `.gitattributes` fix. On 2026-10-03 all four zips matched their sources exactly, so drift was not a live problem.

**How to apply:** Do not re-propose build-time zips unless real zip-vs-source drift appears. Tux design files (tux-og.svg, tux-inkscape.svg, etc.) are likely editable sources of served derivatives (og-image.png, tux.svg); "source beside artifact" matches the bundle convention.

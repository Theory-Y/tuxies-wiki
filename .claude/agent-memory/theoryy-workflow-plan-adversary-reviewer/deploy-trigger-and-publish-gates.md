---
name: deploy-trigger-and-publish-gates
description: How the wiki deploys (push-triggered Cloudflare) and why "don't publish until X" gates are really push-time gates — the SPOF for any staged/gated content plan
metadata:
  type: project
---

The wiki deploys via **repo-connected Cloudflare Pages** (`wrangler.jsonc` serves `docs/.vuepress/dist`; ROADMAP "Open" item sets the CF Pages *Build command* to `npm run build-cf` from the dashboard). The `gh-pages` `npm run deploy` script is a separate, manual GitHub-Pages path. No `.github/workflows/` exist.

**Why this matters for plan review:** the build is whole-site, all-or-nothing (`vuepress build docs`). You cannot ship "the site except one guide." So any plan with a "do NOT publish until X" gate (e.g. a 404-until-uploaded asset, or unverified install commands) is really a **push-time gate, not a deploy-time gate** — the next CF build after the gated content lands on `master` ships it, verified or not.

**How to apply:**
- Treat "human must remember not to deploy" as a single point of failure. The correct control is the *push/commit boundary*, not "deploy later."
- When a batch bundles safe/ungated items with gated ones, flag that bundling them in one commit/push either holds the safe items hostage or leaks the gated ones early → recommend splitting the push boundary.
- VuePress/Plume here does NOT fail the build on dead internal/asset links (no deadlink plugin configured) — a missing asset is a runtime 404, not a build failure. So "render check passes" never catches a broken link or a wrong command. Correctness checks must be separate from render. See [[render-check-is-not-correctness]].

# Action Plan — Logitech setup: beginner-friendly README, zip download & prerequisites note

**Status:** PLANNED (approved scope; awaiting council → execution)
**Deliverable:** A beginner-first rewrite of `resources/logitech-linux-setup/README.md`, a "install
`Solaar` & `Kando` first" prerequisite note in `docs/guides/logitech-linux-setup.md`, and a no-clone
**zip download** option referenced by a fixed permalink in both. The zip file itself is created and
uploaded **manually by the user** (out of band) — this plan only wires up the link and reminds them.
**Definition of done:** README leads with what-you-get + a plain "how to use" path (zip *or* clone → run
`./install.sh` → follow prompts), reference tables demoted below the walkthrough; the guide tells readers
to install `Solaar` and `Kando` before running the installer, framed on the script's REAL behaviour (it
stages presets at the native path and proceeds even when neither app is detected — see step 2), not a
paraphrase; both docs link the zip at `/assets/logitech-linux-setup/logitech-linux-setup.zip`; the README
carries a standing "re-zip if the folder changes" note; render check passes; the user is reminded to drop
the zip at `docs/.vuepress/public/assets/logitech-linux-setup/logitech-linux-setup.zip`.

> **Council amendments (2026-06-22, baseline panel):** (a) #2's prose is done in-session but **must not be
> pushed to `master` until the zip file exists** — Cloudflare rebuilds the whole site on push, so the push
> boundary is the gate, not a deploy step. (b) Step 2's prerequisite note corrected to the script's actual
> staging behaviour. (c) Added an in-README standing re-zip reminder (co-located with the source) instead of
> a one-time note only. (d) The user must zip **after** the README rewrite is committed so the archive
> matches the published page.

## Decisions locked
- **Zip mechanism:** static hosted asset, **user-uploaded manually** (chosen by the user over build-time
  generation / external downloader). Canonical path `docs/.vuepress/public/assets/logitech-linux-setup/
  logitech-linux-setup.zip` → permalink `/assets/logitech-linux-setup/logitech-linux-setup.zip`
  (matches the wiki's `/assets/<slug>/` convention; the image assets already live in that folder).
  Docs reference this permalink; the file lands later. **Not** a build-script edit — keeps #2 clear of the
  open Cloudflare `build-cf` regression.
- The existing GitHub `tree/master/resources/logitech-linux-setup` links (guide lines ~20, 35, 193) stay as
  the "clone / browse" path; the zip is added as the **no-clone** alternative beside the primary download.

## Steps

| # | Step | Owner | Done-condition | Deps |
|---|------|-------|----------------|------|
| 1 | Rewrite `resources/logitech-linux-setup/README.md` beginner-first: open with "what this is / what you get", then a numbered "How to use" (option A: download the zip; option B: clone the folder → `./install.sh` → answer the per-phase prompts). Keep the Directory-structure / Files / Config-paths / Flags tables but move them under a "Reference" heading below the walkthrough. Plain language; keep the existing accurate behaviour notes (interactive, opt-in uinput, idempotent, backups, close Solaar first). Add the zip permalink as option A. Add a one-line **standing note** next to the zip mention: the zip is a *manual snapshot* of this folder — if `install.sh` or any preset changes, re-zip and re-upload to `docs/.vuepress/public/assets/logitech-linux-setup/` (puts the staleness reminder next to the source). | `sonnet-task-executor-high` | README opens with audience + what-you-get, has a step-by-step usage path with the zip option first, tables demoted to a Reference section, standing re-zip note present, no technical claim lost vs current README | — |
| 2 | In `docs/guides/logitech-linux-setup.md`, add a short **prerequisites** note near the installer intro (~line 20): install `Solaar` and `Kando` **before** running `install.sh`. Frame it on the script's ACTUAL behaviour (verified at `install.sh` lines 223 & 313): when neither a Flatpak nor a native install is detected the script prints `No Solaar/Kando install detected; staging config at the native path for first launch.` and **stages the presets anyway, then proceeds** — it does not refuse. So the reason to install first is that the presets only take *effect* once the apps exist; otherwise config is silently staged for an app that isn't there. Add the zip as a no-clone download beside the existing folder link. | `sonnet-task-executor-high` | Guide states the install-first prerequisite framed on the script's real staging behaviour (not a paraphrase); zip permalink present; existing folder link retained | — |
| 3 | Render check: `npm run build` (or `npm run dev` preview) parses the **guide** (note: the README under `resources/` is GitHub-browsed, not built — eyeball it instead); verify the zip link resolves to the agreed permalink (a 404 until the user uploads the file is expected and acceptable). | `sonnet-task-executor-high` | Build parses the guide; README read for claim-preservation; link points at `/assets/logitech-linux-setup/logitech-linux-setup.zip` | 1, 2 |
| 4 | **User reminder (manual, out of band):** user zips `resources/logitech-linux-setup/` **only after the step-1 README rewrite is committed** (so the archive matches the published page) and drops it at `docs/.vuepress/public/assets/logitech-linux-setup/logitech-linux-setup.zip` **before pushing #2 to `master`**. Surface this clearly in the session wrap-up and as a ROADMAP open sub-item. | play-it-yourself (surface only) | Reminder recorded in ROADMAP + session summary | 1, 2 |

## Sequencing
Steps 1 and 2 are independent (different files) → one executor can do both in a single pass since they
share the zip-permalink decision and must stay consistent. Step 3 follows. Step 4 is a standing reminder.

## Risk & reversibility
Low. Pure prose edits to a README and a guide — fully reversible. Only external coupling: the zip link
404s until the user uploads the file, so do **not push these edits to `master`** until the zip is in place
(tracked by step 4). Cloudflare rebuilds the whole site on push, so anything on `master` is effectively
live — the **push boundary is the gate**, not a deploy step no human controls. No build-pipeline changes.
`graphify update` skipped — CLI unavailable in this environment (note in ROADMAP, as prior sessions did).

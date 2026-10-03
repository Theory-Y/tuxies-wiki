---
name: gitattributes-binary-recurrence
description: tuxies-wiki forced `* text` rule corrupted binaries per-type three times (images, videos, zips); a general rule is earned, not speculative
metadata:
  type: project
---

`.gitattributes` began as `* text eol=lf` with per-type `binary` lines bolted on after each corruption: images (initial), videos (commit 92699e3 "Fixing videos keep on corrupting"), zips (HubApps.zip, found 2026-10-03).

**Why:** three recurrences of the same failure class means a general fix (`text=auto`) is justified by evidence, not YAGNI.

**How to apply:** when reviewing plans touching `.gitattributes`, favor the general rule and deleting the per-type lines over adding another per-type line on top. Verify current file state first.

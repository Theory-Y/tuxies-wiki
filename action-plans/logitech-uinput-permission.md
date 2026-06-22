# Action Plan — `uinput` permission fix for Solaar remapping on Wayland

**Status:** PLANNED (approved scope: Wayland-only; awaiting execution)
**Deliverable:** One new `### **Fixing button remaps on Wayland** (uinput permissions)` subsection
inserted into `docs/guides/logitech-linux-setup.md`, immediately after the "Remapping buttons with
rules" steps block (after line 125), covering the symptom, cause, persistent fix, and one-shot
alternative — written to house style and render-verified.
**Scope decision (locked):** Wayland-only gap; no X11 fix needed. Distro-general for the fix
itself (`/etc/udev/rules.d` override + `input` group) — see Pre-flight note §0.

---

## 0. Pre-flight (verify before writing)

- Re-read `CLAUDE.md` and `docs/notes/about/contributions/guidelines.md` at execution time.
- **Distro-general assessment (no per-distro tabs needed):**
  The fix uses two standard Linux primitives that are consistent across distributions:
  1. `/etc/udev/rules.d/` as the local-override directory (this is part of the udev spec, not
     distro-specific).
  2. The `input` group name — present on Fedora, Debian/Ubuntu, and Arch by default; the user need
     only be added to it.
  The `uaccess` failure is also distro-general: it affects any systemd-based desktop (the `uinput`
  device is a `static_node` created at boot with no seat binding). No distro tabs are required.
  **One open question** (see end of plan): confirm that no distro ships a conflicting udev rule at
  a higher-priority path that would shadow the `/etc/udev/rules.d/` override.
- Captured live: Fedora 44 / GNOME Wayland, 2026-06-21. Treat all commands as verified for Fedora;
  flag as "expected to work on all systemd distros" in prose.

---

## 1. Target & insertion point

**File:** `docs/guides/logitech-linux-setup.md`

**Insertion point:** after line 125 (the closing `:::` of the "Remapping buttons with rules" steps
block), before the `## **Part 2: Kando**` heading at line 127.

**Rationale:** The remapping steps block teaches users to create `rules.yaml` rules. The new
section immediately answers "I did that — why does nothing happen?" It sits as a sub-section of
**Part 1: Solaar**, keeping the Kando section clean.

**Heading level to use:** `###` (matches `### **Remapping buttons with rules**` and
`### **Installing Solaar**`). Full heading:
`### **Fixing button remaps on Wayland** (uinput permissions)`

---

## 2. Content outline of the new section

### 2a. Opening paragraph — symptom

One short prose paragraph: device settings all work (battery, DPI, rename, sensitivity) because
those go over `hidraw`, which `uaccess` does grant — but no remapped button fires a keystroke.
This is a ==Wayland-only== issue; on X11 Solaar uses `XTEST` and needs no `uinput` access.

### 2b. `:::warning` callout — Wayland-only scope

Inline (title-only) callout:
`:::warning This fix is only needed on Wayland. X11 sessions use XTEST for synthetic input and are unaffected.`

### 2c. Cause paragraph (brief, non-academic)

Two sentences: on Wayland, Solaar injects synthetic keypresses through `/dev/uinput`. The shipped
`solaar-udev` rule (`/usr/lib/udev/rules.d/42-logitech-unify-permissions.rules`) tags `uinput`
with `uaccess`, but `uaccess` does not work for `uinput` because `uinput` is a `static_node`
created at boot — it is not bound to a login seat, so the per-session ACL is never applied.

### 2d. Persistent fix — `:::steps` block

Three steps, each with a `:::` callout or code block where appropriate:

- **Step 1 — Create a udev override rule**

  Create `/etc/udev/rules.d/60-uinput.rules` with a `:::code-tabs` block showing the file:

  ```
  KERNEL=="uinput", GROUP="input", MODE="0660"
  ```

  Inline note: the filename prefix `60-` ensures this file loads after the shipped `42-` rule and
  takes precedence.

- **Step 2 — Add your user to the `input` group**

  ```bash
  sudo usermod -aG input $USER
  ```

- **Step 3 — Re-login and reload udev**

  ```bash
  sudo udevadm control --reload-rules && sudo udevadm trigger
  ```

  `:::warning` callout (inline): `A full log-out and log back in is required for the group change to take effect; reloading udev alone is not enough.`

### 2e. One-shot alternative — `:::tip` callout

`:::tip` block (NOT a steps block — it is a quick alternative, not a multi-step process):

```bash
sudo setfacl -m u:$USER:rw /dev/uinput
```

Caption: This grants access for the current session only; the ACL is lost at reboot. Use it to
confirm the fix works before committing to the persistent method.

### 2f. Verification sentence

One line: after re-login, press a remapped button in a Wayland session — the assigned keystroke
should now fire.

---

## 3. House-style checklist

- [ ] Heading is `###` with **bold keywords** in title case:
      `### **Fixing button remaps on Wayland** (uinput permissions)`
- [ ] All programs/paths/files in `inline code`: `uinput`, `/dev/uinput`,
      `/etc/udev/rules.d/60-uinput.rules`, `solaar`, `uaccess`, `setfacl`, `udevadm`, `hidraw`,
      `XTEST`, `$USER`, `input`.
- [ ] Prose emphasis uses `==highlight==`, not bold (e.g. ==Wayland-only==, ==persistent==).
- [ ] `:::warning` callouts used for: Wayland-only scope, re-login requirement.
- [ ] `:::tip` callout used for: the `setfacl` one-shot alternative.
- [ ] The udev rule is in a `:::code-tabs` block labelled
      `@tab /etc/udev/rules.d/60-uinput.rules`.
- [ ] The `:::steps` block is at `:::` (innermost); it sits directly under `###` with no outer
      container, so no extra colons needed.
- [ ] No distro tabs — fix is distro-general (per §0 assessment).
- [ ] GB English; "we" voice; concise/professional.
- [ ] Do not use `==highlight==` and `inline code` together on the same term.
- [ ] No bold in step description content — highlighting only for emphasis.

---

## 4. Validation

- **Render check:** `npm run build` (or `npm run dev`) from the repo root — confirm the new
  `:::steps`, `:::warning`, `:::tip`, and `:::code-tabs` blocks parse and render without errors.
- **Colon-nesting check:** the `:::code-tabs` inside the steps block: if it is nested inside the
  `:::steps` container, it must use `::::code-tabs` (one level up). Verify the count is correct
  before submitting.
- **Correctness check (Wayland claim):** The Wayland-vs-X11 split and the `uaccess`/`static_node`
  explanation are sourced from a live debug session (Fedora 44 / GNOME Wayland, 2026-06-21) and
  are considered verified. No additional package-name verification is required (no new packages
  are installed).
- **graphify:** run `graphify update .` after writing if the CLI is available; skip with a note if
  not.

---

## 5. Suggested delegation

**One `sonnet-task-executor-medium`** is appropriate: the insertion point is exact (file:line
125), the section is self-contained, the technical content is fully specified, and no package
verification is needed. Pass this action plan as the brief. A second agent for fact-checking is
not required — all claims originate from a verified live debug session.

---

## References

- **ROADMAP.md** — source task (Wayland `uinput` permission gap, Fedora 44 / GNOME Wayland,
  2026-06-21).
- **`docs/guides/logitech-linux-setup.md` line 125** — insertion point (end of "Remapping buttons
  with rules" steps block).
- **`docs/notes/about/contributions/guidelines.md`** — callout types, colon-nesting rule, heading
  style, tab order, `===highlight===` vs `inline code` rules.
- **`action-plans/rime-input-method-guide.md`** — structural template for this plan.
- `/usr/lib/udev/rules.d/42-logitech-unify-permissions.rules` — the shipped Solaar udev rule
  whose `uaccess` tag on `uinput` is the root cause.

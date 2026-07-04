# key-remapping-with-keyd

This folder contains an interactive installer and a ready-made preset config for the setup
described in the [Key Remapping with keyd guide](../../docs/guides/key-remapping-with-keyd.md).

**What you get:** `keyd-setup.sh` clones and builds `keyd` from source, installs it, writes the
[default.conf](./default.conf) preset to `/etc/keyd/default.conf`, and registers keyd as an
internal keyboard via a `libinput` quirks file to bring back "disable touchpad while typing" behaviour.

The script is interactive — it pauses before each
sudo-heavy phase (build/install, writing the config, registering the quirks file) so you can back
out or inspect what it is about to do, and it opens the config in `nano` (or `$EDITOR`) before
writing it so you can tweak the preset first.

**Prerequisites:** `make` `gcc`
the script doesn't check prereqs, it just tries to build. See the guide's
[Prerequisites](../../docs/guides/key-remapping-with-keyd.md#prerequisites) section for the
distro-specific install commands.

**What is remapped with the script:**

- Copilot key (`leftshift+leftmeta+f23`) → `Ctrl`
- `CapsLock` → `Backspace`
- `Shift`+`CapsLock` → `CapsLock` (so you still have access to Capslock)

Run `keyd-setup.sh` after installing the prerequisites, or copy `default.conf` to
`/etc/keyd/default.conf` yourself and edit it to taste.

See the guide for the full walkthrough,
including how to verify the internal-keyboard registration (type and swipe the
touchpad at the same time — the pointer should stay put).

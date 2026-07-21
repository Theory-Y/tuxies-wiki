# logitech-linux-setup

This folder contains portable dotfiles and an interactive installer for the Logitech Linux setup
described in the [Logitech Linux Setup guide](../../docs/guides/logitech-linux-setup.md).

**What you get:** `install.sh` copies the `Solaar` button-remap preset (`rules.yaml`) and the
`Kando` Actions Ring configuration (`config.json`, `menus.json`) into the correct config
directories on your machine. It auto-detects whether each app is installed as a Flatpak or a
native package, backs up any existing files first, and walks you through each preset so you can
inspect or edit it before it is written.

Install both apps **first** — the presets only do something once the apps exist.

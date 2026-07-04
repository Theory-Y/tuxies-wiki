---
title: Ghostty Terminal Configuration
tags:
  - Beginner
  - Ghostty
  - Terminal
  - Ricing
createTime: 2026/06/11 14:57:00
permalink: /guides/ghostty-terminal/
contributors:
  - aier9500
---

:::info
This guide provides a quickstart using `ghostty` — from the config file itself, to theming, transparency, and window sizing.
:::

::::details Master quick append

Paste into `~/.config/ghostty/config.ghostty`, then reload with `Ctrl`+`Shift`+`,`. Each option is explained in the sections below.

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
# transparency: lower is more transparent (blur needs Blur my Shell on GNOME)
background-opacity = 0.8
background-blur = true

# initial window grid size in columns and rows
window-width = 120
window-height = 40

# restore window state across launches: default | never | always
window-save-state = never
```

:::

::::

On GNOME, `Ctrl`+`Alt`+`Up`/`Down` conflicts with `ghostty`'s split-focus shortcuts — see [Focus-Split Up/Down on GNOME](#focus-split-up-down-on-gnome) below to fix it.

## **Installation**

For the [official install guide from Ghostty](https://ghostty.org/docs/install/binary#linux), see the upstream documentation.

Note that `ghostty` has no single official Linux package except for Arch — the methods below are the recommended community approaches.

::::tabs

@tab ::devicon:fedora:: Fedora

`ghostty` is available via the community COPR repository:

```bash
sudo dnf copr enable scottames/ghostty
sudo dnf install ghostty
```

Alternatively, install via [Terra](https://terra.fyralabs.com/):

```bash
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
sudo dnf install ghostty
```

@tab ::devicon:debian:: Debian/Ubuntu

Ubuntu users can use the community install script:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
```

:::warning
This is an ==Ubuntu-focused installer== and may not be compatible with Debian. Before running any `curl | bash` script, we recommend inspecting it first at [mkasberg/ghostty-ubuntu](https://github.com/mkasberg/ghostty-ubuntu). For anything outside Ubuntu, refer to the [official install guide](https://ghostty.org/docs/install/binary#linux).
:::

@tab ::devicon:archlinux:: Arch

`ghostty` is in the official `[extra]` repository:

```bash
sudo pacman -S ghostty
```

Prerelease builds are available in the AUR as `ghostty-git`.

::::

## **Config File**

### **Location and syntax**

`ghostty` reads its configuration from `~/.config/ghostty/config.ghostty`.

The file uses a simple `key = value` format

- One key per line.
- Keys are ==case-sensitive==.
- Comments must be on their own line starting with `#`; inline trailing comments are not supported.
- Setting a key to an empty value (e.g. `theme =`) resets it to its default.

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
# This is a valid comment
theme = Everforest Dark Hard
background-opacity = 0.8
```

:::

### **Reloading the config**

`Ctrl`+`Shift`+`,` (the default keybind on Linux) to reload it at runtime.

## **Theme and Transparency**

### **Applying a theme**

:::tip
Run `ghostty +list-themes` in a terminal to browse all built-in themes before committing to one.
:::

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
theme = Everforest Dark Hard
```

:::

### **Background transparency and blur**

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
# background-opicity: lower is more transparent
background-opacity = 0.8
background-blur = true
```

:::

:::warning
`background-blur` relies on the KDE blur protocol; on a standard GNOME Wayland session, `background-blur` is ignored. Transparency (`background-opacity`) still works — only blur is N/A.

==If you want blur on GNOME, install the [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/) extension== and enable its `application blur` to blur for `ghostty`.
:::

## **Default Window Size**

The keys `window-width` and `window-height` set the initial terminal grid size in rows and columns.

The default `0` lets the OS or window manager decide. Both keys must be set together for the config to be valid.

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
window-width = 120
window-height = 40
```

:::

`window-save-state` controls whether `ghostty` restores the previous window state (including size) across launches. Accepted values are `default`, `never`, and `always`.

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
window-save-state = never
```

:::

## **Keyboard Shortcuts**

`ghostty` ships with sensible default keybinds. For reference, see [this keyboard shortcuts cheatsheet](https://github.com/Theory-Y/tuxies-wiki/blob/master/resources/ghostty-terminal/keyboard-shortcuts.md).

### **Focus-Split Up/Down on GNOME**

`Ctrl`+`Alt`+`Up` and `Ctrl`+`Alt`+`Down` are grabbed by the GNOME compositor for vertical workspace switching. This means the default focus-split up/down shortcuts do not fire. The left/right directions (`Ctrl`+`Alt`+`Left` / `Ctrl`+`Alt`+`Right`) are unaffected.

==Quick fix==

```bash
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "[]"
```

## **GNOME Keyboard Shortcut**

We can bind a key combo in GNOME `Settings` to launch `ghostty` to access the terminal quickly.

::::steps

- **Open keyboard shortcuts**

  Open `Settings` -> `Keyboard`. Under "Keyboard Shortcuts", click `View and Customise Shortcuts`.

- **Navigate to custom shortcuts**

  Scroll to the bottom of the list and select `Custom Shortcuts`, then click the `+` button to add a new entry.

- **Fill in the shortcut details**

  Enter a name (e.g. "Ghostty") and set the command to `ghostty`.

- **Set the key combo**

  Click `Set Shortcut` and press your desired combination — for example `Super+Return` or `Ctrl+Alt+T`.

- **Confirm**

  Click `Add` to save. The shortcut is active immediately — no logout required.

::::

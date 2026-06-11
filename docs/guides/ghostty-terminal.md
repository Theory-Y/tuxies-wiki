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

::::details Quick append

Paste the full configuration into `~/.config/ghostty/config.ghostty`, then reload with `Ctrl`+`Shift`+`,`. Each option is explained in the sections below.

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
theme = Everforest Dark Hard

# transparency: lower is more transparent (blur needs Blur my Shell on GNOME)
background-opacity = 0.6
background-blur = true

# initial window grid size in columns and rows
window-width = 120
window-height = 32

# restore window size across launches: default | never | always
window-save-state = never
```

:::

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
background-opacity = 0.6
```

:::

### **Reloading the config**

`Ctrl`+`Shift`+`,` (the default keybind on Linux) to reload it at runtime.

## **Everforest Theme and Transparency**

### **Applying the theme**

`ghostty` ships with `Everforest Dark Hard` built in. To apply, add the following:

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
theme = Everforest Dark Hard
```

:::

:::tip
Run `ghostty +list-themes` in a terminal to browse all built-in themes before committing to one.
:::

### **Background transparency and blur**

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
# background-opicity: lower is more transparent
background-opacity = 0.6
background-blur = true
```

:::

:::warning
`background-blur` relies on the KDE blur protocol; on a standard GNOME Wayland session, `background-blur` is ignored. Transparency (`background-opacity`) still works — only blur is N/A.

If you want blur on GNOME, install the [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/) extension and enable its application blur to blur for `ghostty`.
:::

## **Default Window Size**

The keys `window-width` and `window-height` set the initial terminal grid size in rows and columns.

The default `0` lets the OS or window manager decide. Both keys must be set together for the config to be valid.

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
window-width = 120
window-height = 32
```

:::

`window-save-state` controls whether `ghostty` restores the previous window state (including size) across launches. Accepted values are `default`, `never`, and `always`.

:::code-tabs

@tab ~/.config/ghostty/config.ghostty

```ini
window-save-state = never
```

:::

## **GNOME Keyboard Shortcut**

We can bind a key combo in GNOME `Settings` to launch `ghostty` without opening a dock or app grid. The steps below use the standard GNOME custom-shortcut workflow.

::::steps

- **Open keyboard shortcuts**

  Open `Settings` -> `Keyboard`. Under "Keyboard Shortcuts", click `View and Customize Shortcuts`.

- **Navigate to custom shortcuts**

  Scroll to the bottom of the list and select `Custom Shortcuts`, then click the `+` button to add a new entry.

- **Fill in the shortcut details**

  Enter a name (e.g. "Ghostty") and set the command to `ghostty`.

- **Set the key combo**

  Click `Set Shortcut` and press your desired combination — for example `Super+Return` or `Ctrl+Alt+T`.

- **Confirm**

  Click `Add` to save. The shortcut is active immediately — no logout required.

::::

---
title: Kitty Terminal Configuration
tags:
  - Beginner
  - Kitty
  - Terminal
  - Ricing
createTime: 2026/08/10 00:00:00
permalink: /guides/kitty-terminal/
contributors:
  - aier9500
---

:::info
This guide provides a quickstart using `kitty` — from the config file itself, to theming, transparency, and window sizing. `kitty`'s stand-out feature is ==smooth== touchpad scrolling, where most terminals jump whole lines at a time.
:::

::::details Master quick append

Paste into `~/.config/kitty/kitty.conf`, then reload with `Ctrl`+`Shift`+`F5`. Each option is explained in the sections below.

:::code-tabs

@tab ~/.config/kitty/kitty.conf

```ini
# transparency: lower is more transparent (blur needs Blur my Shell on GNOME)
background_opacity 0.8
background_blur 1

# start at a fixed grid size: "c" means cells (columns and rows), not pixels
remember_window_size no
initial_window_width 120c
initial_window_height 40c
```

:::

::::

## **Installation**

`kitty` is in the official repositories of all major distros.

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install kitty
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install kitty
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S kitty
```

:::

Distro packages can lag behind releases. If you want the newest version, see the [official install guide from Kitty](https://sw.kovidgoyal.net/kitty/binary/).

## **Config File**

### **Location and syntax**

`kitty` reads its configuration from `~/.config/kitty/kitty.conf`.

The file uses a simple `key value` format

- One key per line, separated by a ==space== — no `=` sign.
- Keys are ==case-sensitive==.
- Comments must be on their own line starting with `#`; inline trailing comments are not supported.

:::code-tabs

@tab ~/.config/kitty/kitty.conf

```ini
# This is a valid comment
background_opacity 0.8
```

:::

### **Reloading the config**

`Ctrl`+`Shift`+`F5` (the default keybind on Linux) to reload it at runtime. Newer versions of `kitty` also pick up saved changes automatically.

## **Theme and Transparency**

### **Applying a theme**

`kitty` has a built-in theme picker with live preview. Run it in a terminal, browse with the arrow keys, and press `Enter` to apply:

```bash
kitten themes
```

:::tip
Already know the theme you want? Apply it directly and reload every open window:

```bash
kitten themes --reload-in=all Everforest Dark Hard
```

:::

::::details How the picker saves your choice (technical detail)
The kitten writes the chosen colours to `~/.config/kitty/current-theme.conf` and adds an `include current-theme.conf` line to `kitty.conf`. To change themes later, just run the kitten again — no manual editing needed.
::::

### **Background transparency and blur**

:::code-tabs

@tab ~/.config/kitty/kitty.conf

```ini
# background_opacity: lower is more transparent
background_opacity 0.8
background_blur 1
```

:::

:::warning
`background_blur` only works where the system provides blur — KDE Plasma on Wayland and macOS. On a standard GNOME session it is ignored. Transparency (`background_opacity`) still works — only blur is N/A.

==If you want blur on GNOME, install the [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/) extension== and enable its `application blur` for `kitty`.
:::

## **Default Window Size**

By default, `kitty` remembers the size of the last window you closed and reuses it (`remember_window_size yes`). To start at a fixed size instead, turn that off and set the initial size yourself:

:::code-tabs

@tab ~/.config/kitty/kitty.conf

```ini
remember_window_size no
initial_window_width 120c
initial_window_height 40c
```

:::

The `c` suffix means the size is in terminal ==cells== (columns and rows). Without it, the numbers are pixels.

## **Keyboard Shortcuts**

Most shortcuts start with `kitty_mod`, which is `Ctrl`+`Shift` by default. The most useful ones:

- `Ctrl`+`Shift`+`C` / `Ctrl`+`Shift`+`V` — copy / paste
- `Ctrl`+`Shift`+`T` — new tab
- `Ctrl`+`Shift`+`Enter` — new window (split)
- `Ctrl`+`Shift`+`]` / `Ctrl`+`Shift`+`[` — next / previous window
- `Ctrl`+`Shift`+`=` / `Ctrl`+`Shift`+`-` — bigger / smaller text

Every keybind can be remapped with the `map` option — see the [official shortcuts reference](https://sw.kovidgoyal.net/kitty/conf/#keyboard-shortcuts).

## **GNOME Keyboard Shortcut**

We can bind a key combo in GNOME `Settings` to launch `kitty` to access the terminal quickly.

::::steps

- **Open keyboard shortcuts**

  Open `Settings` -> `Keyboard`. Under "Keyboard Shortcuts", click `View and Customise Shortcuts`.

- **Navigate to custom shortcuts**

  Scroll to the bottom of the list and select `Custom Shortcuts`, then click the `+` button to add a new entry.

- **Fill in the shortcut details**

  Enter a name (e.g. "Kitty") and set the command to `kitty`.

- **Set the key combo**

  Click `Set Shortcut` and press your desired combination — for example `Super+Return` or `Ctrl+Alt+T`.

- **Confirm**

  Click `Add` to save. The shortcut is active immediately — no logout required.

::::

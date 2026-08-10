---
title: Fcitx5 Customisation
tags:
  - Beginner
  - Fcitx5
  - Input
  - Ricing
createTime: 2026/08/10 14:57:00
permalink: /guides/fcitx5-customisation/
contributors:
  - Lunear01
---

:::info What is `fcitx5`?
`fcitx5` is an ==input method framework== — the layer between your keyboard and your apps that lets you type languages a physical keyboard cannot cover on its own, such as Chinese, Japanese, or Korean. You type letters, a small pop-up offers matching characters, and you pick one.

This is the one we use in ==tilling WM== such as **hyprland** or **niri**
:::

::::details Quick append

Install the theme [Ori-fcitx5](https://github.com/Reverier-Xu/Ori-fcitx5) to `~/.local/share/fcitx5/themes`

Paste the block below into `~/.config/fcitx5/conf/classicui.conf`, then restart `fcitx5`.

:::code-tabs

@tab ~/.config/fcitx5/conf/classicui.conf

```ini
# Vertical Candidate List
Vertical Candidate List=False
# Use mouse wheel to go to prev or next page
WheelForPaging=True
# Font
Font="Noto Sans CJK SC 12"
# Menu Font
MenuFont="Noto Sans CJK SC 12"
# Tray Font
TrayFont="Noto Sans CJK SC Bold 10"
# Tray Label Outline Color
TrayOutlineColor=#000000
# Tray Label Text Color
TrayTextColor=#ffffff
# Prefer Text Icon
PreferTextIcon=False
# Show Layout Name In Icon
ShowLayoutNameInIcon=True
# Use input method language to display text
UseInputMethodLanguageToDisplayText=True
# Theme
Theme=OriDark
# Dark Theme
DarkTheme=OriDark
# Follow system light/dark color scheme
UseDarkTheme=False
# Follow system accent color if it is supported by theme and desktop
UseAccentColor=True
# Use Per Screen DPI on X11
PerScreenDPI=False
# Force font DPI on Wayland
ForceWaylandDPI=0
# Enable fractional scale under Wayland
EnableFractionalScale=True
```

:::

::::

## **Installing Fcitx5**

::::tabs#distro

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-autostart
```

`fcitx5-gtk` and `fcitx5-qt` pull in the GTK 3/4 and Qt 5/6 frontends. `fcitx5-autostart` launches `fcitx5` when you log in, so you can skip the [autostart step](#starting-fcitx5-with-your-session).

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install fcitx5 fcitx5-configtool fcitx5-frontend-gtk3 fcitx5-frontend-gtk4 fcitx5-frontend-qt5
```

On Debian 13 (trixie), Ubuntu 24.04 and newer, add `fcitx5-frontend-qt6` to cover Qt 6 apps.

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt
```

Everything sits in the `extra` repository — no AUR helper needed.

::::

### **Fonts**

The config in this guide asks for ==Noto Sans CJK SC==. Without it the pop-up falls back to any font it can find, and Chinese characters often show as empty boxes.

:::tabs#distro

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install google-noto-sans-cjk-fonts
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install fonts-noto-cjk
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S noto-fonts-cjk
```

:::

### **Environment variables**

:::tip On a Wayland session (the default on modern GNOME and KDE), apps reach `fcitx5` through Wayland's own text-input protocol and ==no environment variables are needed==. Try typing first — if it works, skip this section.
:::

On X11, and for older apps running through XWayland, you point the toolkits at `fcitx5` yourself. Create the file below:

:::code-tabs

@tab ~/.config/environment.d/fcitx5.conf

```ini
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```

:::

Log out and back in for these to take effect.

## **Installing the OriDark Theme**

[`OriDark`](https://github.com/Reverier-Xu/Ori-fcitx5) is a minial dark theme with rounded corners.


:::steps

- **Create the themes folder**

  ```bash
  mkdir -p ~/.local/share/fcitx5/themes
  ```

- **Download the theme**

  ```bash
  git clone https://github.com/Reverier-Xu/Ori-fcitx5.git /tmp/ori-fcitx5
  ```

- **Copy both variants across**

  ```bash
  cp -r /tmp/ori-fcitx5/OriDark /tmp/ori-fcitx5/OriLight ~/.local/share/fcitx5/themes/
  ```

  `OriLight` is the matching light variant. Copy it too so you can switch later.

:::

Check that the theme arrived:

```bash
ls ~/.local/share/fcitx5/themes/
```

`OriDark` and `OriLight` appear alongside the built-in `default` and `default-dark`.

:::warning The folder name ==is== the theme name. `Theme=OriDark` in the config below only works if the folder is spelled exactly `OriDark`, capital letters included.
:::

## **The Appearance Config**

Every visual setting lives in one file: `~/.config/fcitx5/conf/classicui.conf`. `classicui` is the part of `fcitx5` that draws the pop-up and the tray icon, so the theme, the fonts, and the scaling behaviour are set here.

Create the folder if this is a fresh install, then open the file in any text editor:

```bash
mkdir ~/.config/fcitx5/conf
nano ~/.config/fcitx5/conf/classicui.conf
```

Paste in the following:

:::code-tabs

@tab ~/.config/fcitx5/conf/classicui.conf

```ini
# Vertical Candidate List
Vertical Candidate List=False
# Use mouse wheel to go to prev or next page
WheelForPaging=True
# Font
Font="Noto Sans CJK SC 12"
# Menu Font
MenuFont="Noto Sans CJK SC 12"
# Tray Font
TrayFont="Noto Sans CJK SC Bold 10"
# Tray Label Outline Color
TrayOutlineColor=#000000
# Tray Label Text Color
TrayTextColor=#ffffff
# Prefer Text Icon
PreferTextIcon=False
# Show Layout Name In Icon
ShowLayoutNameInIcon=True
# Use input method language to display text
UseInputMethodLanguageToDisplayText=True
# Theme
Theme=OriDark
# Dark Theme
DarkTheme=OriDark
# Follow system light/dark color scheme
UseDarkTheme=False
# Follow system accent color if it is supported by theme and desktop
UseAccentColor=True
# Use Per Screen DPI on X11
PerScreenDPI=False
# Force font DPI on Wayland
ForceWaylandDPI=0
# Enable fractional scale under Wayland
EnableFractionalScale=True
```

:::


::::details Fcitx5 GUI

The settings app offers the same options:

```bash
fcitx5-configtool
```

Go to the `Appearance` tab and pick your theme and fonts there. The app writes the same `classicui.conf`, so both routes are equivalent — the file is just faster to copy between machines.

::::

## **Setting Up Rime**

An input method framework does not know any Chinese on its own. It needs an ==engine==: the part that reads `nihao` and offers you 你好. [`rime`](https://rime.im/) is one such engine, and the most configurable one available.

:::tabs#distro

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install fcitx5-rime brise
```

`brise` is Fedora's bundle of ready-made schemas, including the default Pinyin one.

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install fcitx5-rime
```

The default Pinyin schema comes along with it.

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S fcitx5-rime
```

The default Pinyin schema comes along with it.

:::

With the engine installed, wire it into `fcitx5`:

::::steps

- **Add Rime to your input methods**

  Open the settings app:

  ```bash
  fcitx5-configtool
  ```

  On the `Input Method` tab, untick ==Only Show Current Language==, find ==Rime== in the list on the right, and click the arrow to move it across. Keep your normal keyboard layout at the top of the list and `Rime` below it.

  :::warning If the list on the left is empty, `fcitx5` is not running. Run `fcitx5 -d` and reopen the settings app.
  :::

- **Try it out**

::::

### **Choosing your schemas**

A ==schema== is one way of typing — Pinyin, Jyutping, Wubi, and so on. `rime` ships with several but enables only a couple by default. You pick yours in a small settings file of your own.

:::info Never edit `rime`'s own files under `/usr/share/rime-data/`. Write a ==patch== instead — a short file listing only what you want changed. `rime` merges it over its defaults, so your choices survive every update.
:::

Create `~/.local/share/fcitx5/rime/default.custom.yaml`:

```bash
mkdir ~/.local/share/fcitx5/rime
nano ~/.local/share/fcitx5/rime/default.custom.yaml
```

:::code-tabs

@tab ~/.local/share/fcitx5/rime/default.custom.yaml

```yaml
patch:
  schema_list:
    - schema: luna_pinyin
```

:::

`luna_pinyin` is Mandarin Pinyin, and `rime` starts with the first entry in the list. Add a line per schema you want, in the order you want them offered.

:::warning A schema name must match a filename in `/usr/share/rime-data/` exactly — underscores, no hyphens. Get it wrong and `rime` quietly falls back to its defaults with no error.
:::

To list what you already have:

```bash
ls /usr/share/rime-data/*.schema.yaml
```

Strip the `.schema.yaml` off any filename and you have a name for the list — `bopomofo`, `cangjie5`, `wubi86`, and so on.

#### Adding Cantonese

Cantonese Jyutping is the common extra, and the one place the distros disagree — both the package ==and== the schema name differ.

::::tabs#distro

@tab ::devicon:fedora:: Fedora

`brise`, installed earlier, already carries Cantonese, so no extra package is needed. Fedora calls it `jyutping` rather than `jyut6ping3`:

```yaml
patch:
  schema_list:
    - schema: luna_pinyin
    - schema: jyutping
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install rime-data-jyut6ping3
```

Then use the name `jyut6ping3`:

```yaml
patch:
  schema_list:
    - schema: luna_pinyin
    - schema: jyut6ping3
```

:::warning Ubuntu 22.04 LTS does not carry this package. Upgrade to 24.04 or newer, or fetch the schema by hand from [`rime/rime-cantonese`](https://github.com/rime/rime-cantonese) into `~/.local/share/fcitx5/rime/`.
:::

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S rime-cantonese
```

Then use the name `jyut6ping3`:

```yaml
patch:
  schema_list:
    - schema: luna_pinyin
    - schema: jyut6ping3
```

::::

### **Deploying**

`rime` compiles its configuration into a fast lookup format, and only when you ask. That step is a ==deploy==, and it is required after ==every== config change.

:::steps

- **Trigger the deploy**

  Right-click the `fcitx5` tray icon and choose ==Rime== → ==Deploy==. It takes a few seconds — longer the first time, as the dictionaries are built from scratch.

- **Check that it worked**

  ```bash
  ls ~/.local/share/fcitx5/rime/build/
  ```

  Compiled files such as `luna_pinyin.schema.yaml` appear. An empty folder means the deploy did not run.

- **Switch between schemas**

  With `Rime` active, press `F4` to open the schema menu and pick Pinyin or Jyutping. This is separate from `Ctrl`+`Space`, which switches between `Rime` and your plain keyboard layout.

:::

::::details Where your personal data lives

`rime` learns from you — the words you pick most often float to the top over time. That history sits in `~/.local/share/fcitx5/rime/` in files ending in `.userdb`, next to your `default.custom.yaml`.

Back up that whole folder and your typing habits move with you to a new machine. The `build/` subfolder inside it is throwaway — the next deploy regenerates it.

::::
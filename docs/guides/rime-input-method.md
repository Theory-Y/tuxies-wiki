---
title: Rime Input Method Setup
tags:
  - Beginner
  - Rime
  - IBus
  - Productivity
createTime: 2026/06/22 00:00:00
permalink: /guides/rime-input-method/
contributors:
  - aier9500
draft: true
---

:::info
This guide walks through setting up the `rime` input method engine via `ibus-rime` on a GNOME desktop. We will enable two schemas — ==Mandarin Pinyin== (`luna_pinyin`) and ==Cantonese Jyutping== (`jyut6ping3`) — so you can switch between them inside a single input source.

**Prerequisites:** A GNOME desktop with `ibus` running as the input method framework (the default on Fedora and Ubuntu GNOME spins).
:::

::::details Quick append

Paste the block below into `~/.config/ibus/rime/default.custom.yaml` (create the file if it does not exist), then deploy Rime from the `ibus` tray icon. Each section is explained below.

:::code-tabs

@tab ~/.config/ibus/rime/default.custom.yaml

```yaml
patch:
  schema_list:
    - schema: luna_pinyin
    - schema: jyut6ping3
```

:::

::::

## **Installation**

:::tip
On Fedora, a single package pulls in everything including the Cantonese schema. On Debian, Ubuntu, and Arch, the `jyut6ping3` schema data is ==split into a separate package== and must be installed explicitly — see the tabs below.
:::

::::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install ibus-rime
```

`ibus-rime` pulls in `librime` (the engine) and `brise` (the schema data bundle, which includes both `luna_pinyin` and `jyut6ping3`). No additional packages are needed.

After installing, verify that the Jyutping schema data is present:

```bash
rpm -ql brise | grep jyut6ping3
```

If the command returns at least one path (e.g. `/usr/share/rime-data/jyut6ping3.schema.yaml`), the schema is ready to enable. If it returns nothing, see the [Cantonese fallback](#cantonese-fallback) section below.

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install ibus-rime rime-data-jyut6ping3
```

`ibus-rime` installs `librime-data` (which Recommends `rime-data-luna-pinyin`, covering Pinyin). `jyut6ping3` is ==not== pulled automatically — `rime-data-jyut6ping3` must be added explicitly.

:::warning Ubuntu 22.04 LTS (jammy) does not include `rime-data-jyut6ping3` in its apt repositories. If you are on 22.04, skip this package and use the [Cantonese fallback](#cantonese-fallback) instead (manual install from the upstream `rime/rime-cantonese` repo). Ubuntu 24.04 (noble) and newer, and Debian bookworm and newer, all have the package available.
:::

After installing, check that the Jyutping schema file is present:

```bash
find /usr/share/rime-data -name "jyut6ping3*"
```

If no file is found, see the [Cantonese fallback](#cantonese-fallback) section below.

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S ibus-rime rime-cantonese
```

`rime-cantonese` is in the official `extra` repository — no AUR helper required. `luna_pinyin` is pulled in automatically as a hard dependency (via `librime` → `librime-data`). `jyut6ping3` requires `rime-cantonese` explicitly.

After installing, check that the Jyutping schema file is present:

```bash
find /usr/share/rime-data -name "jyut6ping3*"
```

If no file is found, see the [Cantonese fallback](#cantonese-fallback) section below.

::::

## **Enabling the Schemas**

Rime's active schemas are controlled by a ==configuration patch file== at `~/.config/ibus/rime/default.custom.yaml`. The `patch:` key overrides selected values from Rime's built-in defaults without replacing the entire config — anything not listed in `patch:` remains at its default.

Create or open the file in a text editor — a GUI editor such as `gnome-text-editor` works perfectly:

```bash
gnome-text-editor ~/.config/ibus/rime/default.custom.yaml
```

Add the following content:

:::code-tabs

@tab ~/.config/ibus/rime/default.custom.yaml

```yaml
patch:
  schema_list:
    - schema: luna_pinyin
    - schema: jyut6ping3
```

:::

::::details Why `patch:` instead of a full config file

Rime ships with its own `default.yaml` containing many defaults. If you create a `default.yaml` in your user directory it ==replaces== the entire system file, which means you lose any future upstream improvements. The `default.custom.yaml` + `patch:` approach ==merges== your overrides on top, so you only specify what you want to change.

::::

Save the file. The schema IDs (`luna_pinyin`, `jyut6ping3`) must match the filenames in `/usr/share/rime-data/` exactly (underscores, no hyphens).

## **Deploying**

After saving `default.custom.yaml`, Rime must rebuild its compiled configuration before the new schemas take effect.

:::steps

- **Open the IBus tray menu**

  Click the keyboard icon in the GNOME system tray (or look for the `ibus` indicator). Select ==Deploy== from the menu.

  Rime will process the schema files and write the compiled output to `~/.config/ibus/rime/build/`. This takes a few seconds.

- **Verify the deploy completed**

  Check that the build directory is populated:

  ```bash
  ls ~/.config/ibus/rime/build/
  ```

  You should see files such as `luna_pinyin.schema.yaml` and `jyut6ping3.schema.yaml` among the output.

- **If the tray icon is not visible**

  Log out and back in to restart the `ibus` daemon, then try again.

:::

## **Adding the GNOME Input Source**

Once Rime is deployed, add it as an input source in GNOME so it appears in the language switcher.

:::steps

- **Open keyboard settings**

  Go to `Settings` → `Keyboard` → `Input Sources`, then click the `+` button.

- **Select the language**

  Search for and select ==Chinese==.

- **Select Rime**

  From the Chinese variants listed, choose ==Chinese (Rime)==.

- **Confirm**

  Click `Add`. The Rime input source will now appear in your input source list.

:::

Alternatively, add it in one command via `gsettings`:

```bash
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'gb'), ('ibus', 'rime')]"
```

:::warning This command ==replaces== your entire input source list. Adjust the `('xkb', 'gb')` entry to match your existing keyboard layout before running it (e.g. `('xkb', 'us')` for US QWERTY).
:::

## **Switching Between Input Sources and Schemas**

There are two levels of switching:

| Action              | Default keybind        | What it does                                                                                                 |
| ------------------- | ---------------------- | ------------------------------------------------------------------------------------------------------------ |
| Switch input source | `Super`+`Space`        | Cycles between all input sources in GNOME (e.g. your keyboard layout ↔ Rime)                                 |
| Switch Rime schema  | `F4` or `Ctrl`+`` ` `` | Opens the Rime schema switcher menu — choose `luna_pinyin` for Pinyin or `jyut6ping3` for Cantonese Jyutping |

`Super`+`Space` is a GNOME-level bind and works regardless of which application is focused. `F4` / `Ctrl`+`` ` `` are Rime-internal — they only work when Rime is the active input source.

## **Cantonese Fallback**

:::warning This section applies if the `jyut6ping3` availability check in the [Installation](#installation) section returned no files. The most common case is ==Ubuntu 22.04 LTS (jammy)==, which does not include `rime-data-jyut6ping3` in apt. It also applies to any other distro or release where the package is unavailable.
:::

The canonical Cantonese schema lives in the [`rime/rime-cantonese`](https://github.com/rime/rime-cantonese) repository on GitHub. To install it manually:

:::steps

- **Ensure the Rime user directory exists**

  ```bash
  mkdir -p ~/.config/ibus/rime
  ```

- **Download the schema files**

  Clone or download the repository, then copy the required files into your Rime user directory:

  ```bash
  git clone https://github.com/rime/rime-cantonese.git /tmp/rime-cantonese
  cp /tmp/rime-cantonese/jyut6ping3*.yaml ~/.config/ibus/rime/
  ```

- **Redeploy Rime**

  Click ==Deploy== in the `ibus` tray menu (or log out and back in). Rime will pick up the new schema files from `~/.config/ibus/rime/` and compile them alongside the system-installed schemas.

:::

After redeploying, verify `jyut6ping3` appears when you press `F4` or `Ctrl`+`` ` `` inside Rime.

## **Resources**

- [rime.im](https://rime.im/) — official Rime project site
- [rime/ibus-rime](https://github.com/rime/ibus-rime) — IBus frontend source
- [rime/rime-cantonese](https://github.com/rime/rime-cantonese) — upstream Cantonese Jyutping schema
- [ArchWiki — Rime](https://wiki.archlinux.org/title/Rime) — distro-agnostic setup notes and troubleshooting

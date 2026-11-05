---
title: aier's Fedora
createTime: 2026/07/21 00:00:00
permalink: /guides/aiers-fedora/
tags:
  - Beginner
  - Fedora
  - Hyprland
  - Gnome
contributors:
  - aier
---

:::info My personal Fedora setup, one pick per need. Written for me, so the explanations are short. Optional extras sit at the bottom.
:::

## **First Steps**

- [Fedora Guide](/linux-guides/fedora/)
- [Keyd](/guides/key-remapping-with-keyd/)

## **Desktop**

### **Hyprland + DMS**

- [hypr-dms](https://github.com/aier9500/hypr-dms)

  :::info Hyprland with DankMaterialShell (DMS): the bar, launcher, lock screen and settings app. Install DMS and link one folder; DMS Settings covers the rest.
  :::

- [Fcitx5](/guides/fcitx5-customisation/) _(Chinese input)_

  :::info hypr-dms installs Fcitx5 with Rime and starts it at login. Add Rime in Fcitx5 Configuration to type Chinese.
  :::

### **Gnome** as a fallback

- [Gnome Guide](/linux-guides/gnome/)
- [Further Gnome Customisation](/guides/gnome-further-customisation/)

## **Terminal**

- [Ghostty](/guides/ghostty-terminal/)

- [fastfetch](https://github.com/fastfetch-cli/fastfetch)

  :::tip My config
  [Download the zip](/assets/aiers-fedora/aiers-fastfetch-config.zip), extract it, and save `config.jsonc` to `~/.config/fastfetch/config.jsonc`.
  :::

## **Apps**

- [Essentials](/linux-apps/essentials/)

## **Face Unlock**

- [Gaze](https://gaze.gundulabs.com/)

  :::info Face unlock for Linux, like Windows Hello.
  :::

::::details Install steps

:::steps

- **Install**

  The script adds the Gaze repo, installs Gaze and its settings app, and starts the face service.

  ```bash
  curl -fsSL https://gaze.gundulabs.com/install.sh | sh
  ```

- **Reboot**

- **Never wait for the camera**

  By default the password prompt waits until face recognition gives up. This runs both at once: ==look at the camera or just type==. A wrong password, or Enter on an empty field, gives the camera a second look.

  ```bash
  sudo authselect enable-feature with-face-simultaneous
  sudo authselect enable-feature with-face-retry
  ```

- **Password first on the DMS lock screen**

  The DMS lock screen still waits for the camera before it checks a typed password. This makes a copy of its login rules with the password checked first:

  ```bash
  cd ~/.local/state/DankMaterialShell/pam
  sed -e '/pam_gaze.so/d' -e 's/^\(auth.*pam_unix.so.*\)$/\1\nauth        sufficient                                   pam_gaze.so/' dankshell > dankshell-gaze
  ```

  Pick `dankshell-gaze` in DMS Settings → Lock Screen → Authentication → `Custom…`. A typed password unlocks at once; Enter on the empty field uses your face.

- **Add your face**

  Open Gaze from the launcher and enrol your face. Test it in a terminal: `sudo echo test`.

:::

:::tip Uninstall
`gaze uninstall` removes Gaze and restores your previous login settings. Add `--keep-data` to keep your enrolled face.
:::

::::

## **Hardware**

- [ProArt P16 2025](/guides/proart-p16-2025/)

## **Extras**

- [Editor's choice](/linux-apps/editors-choice/) — more apps worth a look
- [Kitty](/guides/kitty-terminal/) — an alternative terminal
- [Terminal customisation](/guides/terminal-customisation/) — `bash` prompt, autorun `fastfetch`
- [yazi](/guides/yazi/) — terminal file manager

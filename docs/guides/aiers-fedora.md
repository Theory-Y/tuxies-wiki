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

- **Add the repo and install**

  Hopefully Gaze will be packaged into the `fedora` or `terra` in the future when mature. For now, we import the repo manually.

  ```bash
  sudo rpm --import https://packages.gundulabs.com/keys/gundulabs-repo.asc
  sudo tee /etc/yum.repos.d/gundulabs.repo > /dev/null << 'EOF'
  [gundulabs]
  name=Gundu Labs
  baseurl=https://packages.gundulabs.com/rpm/fedora/$releasever/$basearch
  enabled=1
  gpgcheck=1
  repo_gpgcheck=1
  gpgkey=https://packages.gundulabs.com/keys/gundulabs-repo.asc
  EOF
  sudo dnf makecache
  sudo dnf install gaze gaze-gui
  ```

- **Reboot**

- **Start the `gazed` daemon**

  ```bash
  sudo systemctl enable --now gazed
  ```

- **Select the Gaze `authselect` profile**

  `with-face-simultaneous` allows you to input password the same time the facial recognition is firing.

  ```bash
  sudo authselect select gaze with-face-simultaneous with-silent-lastlog --force
  ```

- **Configure & Test**

  Set up face in the Gaze GUI, along with tweaking some of its settings.

  Try in the terminal: `sudo echo test`.

- **Skip the face wait on the DMS lock screen**

  The DMS lock screen waits for face recognition to fail before it checks a typed password. Copy its login rules and put the password first:

  ```bash
  cd ~/.local/state/DankMaterialShell/pam
  cp dankshell dankshell-gaze
  $EDITOR dankshell-gaze
  ```

  Move the `pam_unix.so` line above the `pam_gaze.so` line:

  ```ini
  auth    sufficient  pam_unix.so nullok try_first_pass
  auth    sufficient  pam_gaze.so
  ```

  Then pick the file in DMS Settings → Lock Screen → Authentication → `Custom…`.

:::

::::

## **Hardware**

- [ProArt P16 2025](/guides/proart-p16-2025/)

## **Extras**

- [Editor's choice](/linux-apps/editors-choice/) — more apps worth a look
- [Kitty](/guides/kitty-terminal/) — an alternative terminal
- [Terminal customisation](/guides/terminal-customisation/) — `bash` prompt, autorun `fastfetch`
- [yazi](/guides/yazi/) — terminal file manager

---
title: aier's Fedora
createTime: 2026/07/21 00:00:00
permalink: /guides/aiers-fedora/
tags:
  - Beginner
  - Fedora
  - Gnome
  - Niri
contributors:
  - aier
---

:::info My personal Fedora setup — the full checklist I follow, plus a couple of fixes I always apply. This one is written for me, so the explanations are short.
:::

## **First Steps**

- [Fedora Guide](/linux-guides/fedora/)
- [Keyd](/guides/key-remapping-with-keyd/)

## **Further Setup**

### **Dev stuff**

- [Terminal customisation](/guides/terminal-customisation/)
- [ghostty-terminal](/guides/ghostty-terminal/)
- [yazi](/guides/yazi/)

### **Apps**

- [Editor's choice](/linux-apps/editors-choice/)
- [Essentials](/linux-apps/essentials/)

### **Misc**

- Facial Recognition with [Gaze](https://gaze.gundulabs.com/)

:::note Older Gaze versions broke automatic keyring unlock at `GDM` login, needing a custom `authselect` profile with `pam_gaze` stripped from `password-auth`. Fixed upstream — the stock profile now works as is.
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

:::

::::

## **Desktop / Hardware-Dependent**

### **Niri**

- My [niri-dms](https://github.com/aier9500/niri-dms) repo

### **Gnome**

- [Gnome Guide](/linux-guides/gnome/)
- [Further Gnome Customisation](/guides/gnome-further-customisation/)
- [External Resources](/guides/external-resources/#gnome/)
  - Gnome touchpad scrolling speed fix

### **Hardware**

- [Logitech Linux Setup](/guides/logitech-linux-setup/)
- [ProArt P16 2025](/guides/proart-p16-2025/)

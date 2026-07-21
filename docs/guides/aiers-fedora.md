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

- [Bash customisation](/guides/terminal-customisation-bash/)
- [ghostty-terminal](/guides/ghostty-terminal/)
- [yazi](/guides/yazi/)

### **Apps**

- [Editor's choice](/linux-apps/editors-choice/)
- [Essentials](/linux-apps/essentials/)

### **Misc**

- Facial Recognition with [Gaze](https://gaze.gundulabs.com/)

:::warning

Gaze's manual install (via adding repository) enables the `GDM` login, requiring a manual password entry for apps using keyrings.

This can be solved by modifying a copy of the stock Gaze authentification profile.
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

- **Wire it up, minus the login screen**

  ```bash
  # copy stock profile
  sudo authselect create-profile gaze-nogdm --base-on=gaze
  # delete all lines containing pam_gaze in password-auth
  sudo sed -i '/pam_gaze/d' /etc/authselect/custom/gaze-nogdm/password-auth
  # select & apply custom profile
  sudo authselect select custom/gaze-nogdm with-silent-lastlog --force
  sudo authselect apply-changes
  ```

- **Check**

  `sudo echo test` fires the camera. After a reboot the login screen asks for my password, and the keyring unlocks on its own.

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

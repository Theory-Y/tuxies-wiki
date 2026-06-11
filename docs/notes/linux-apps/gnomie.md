---
title: Gnomie
createTime: 2025/05/29 08:29:45
permalink: /linux-apps/gnomie/
contributors:
  - aier
  - Lunear
---

:::warning TODO: Separate extensions from actual applications.
:::

## **[Dconf Editor](https://flathub.org/apps/ca.desrt.dconf-editor)**

GUI to edit GSettings/Dconf database (advanced Gnome system settings).

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub ca.desrt.dconf-editor
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub ca.desrt.dconf-editor
```

:::

:::important
If you think that some settings are missing in Dconf, install your distro’s package instead of the Flatpak.
:::

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install dconf-editor
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S dconf-editor
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install dconf-editor
```

:::

## **[Extension Manager](https://flathub.org/apps/com.mattjakeman.ExtensionManager)**

GUI to modify Gnome Extensions.

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub com.mattjakeman.ExtensionManager
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub com.mattjakeman.ExtensionManager
```

:::

## **[Gnome Tweaks](https://github.com/GNOME/gnome-tweaks)**

Change fonts, manage shell themes (requires `User Theme` extension), add hide and maximise buttons, and more!

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install gnome-tweaks
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S gnome-tweaks
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install gnome-tweaks
```

:::

## **[SaveDesktop](https://flathub.org/apps/io.github.vikdevelop.SaveDesktop)**

Save your desktop

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub io.github.vikdevelop.SaveDesktop
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub io.github.vikdevelop.SaveDesktop
```

:::

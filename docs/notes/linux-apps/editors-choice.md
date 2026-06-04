---
title: Editor's Choice
createTime: 2025/05/22 09:05:08
permalink: /linux-apps/editors-choice/
contributors:
  - aier
  - Lunear
---

## **[LocalSend](https://localsend.org/)**

:::details Open-source, cross-platform file sharer to nearby devices.
![Localsend Demo](/assets/editors-choice/localsend-demo.png)
:::

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub org.localsend.localsend_app
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub org.localsend.localsend_app
```

@tab ::devicon:archlinux:: Arch (AUR)

```bash
yay -S localsend-bin
```

:::

## **[Inkscape](https://flathub.org/apps/org.inkscape.Inkscape)**

Open-source vector graphic editor

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub org.inkscape.Inkscape
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user org.inkscape.Inkscape
```

:::

## **[Zen Browser](https://flathub.org/apps/app.zen_browser.zen)**

:::details A feature-rich, Firefox based browser that just works with smooth animations and QoL features.
![Zen Demo](/assets/editors-choice/zen-demo.png)
:::

:::tabs
@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub app.zen_browser.zen
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub app.zen_browser.zen
```

@tab ::devicon:archlinux:: Arch (AUR)

```bash
yay -S zen-browser-bin
```

:::

## **[Bitwarden](https://bitwarden.com/)**

:::details Safe, trusted password manager.
![Bitwarden Demo](/assets/editors-choice/bitwarden-demo.png)
:::

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub com.bitwarden.desktop
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub com.bitwarden.desktop
```

:::

Bitwarden is also offered as a browser extension:
[Firefox](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/?browser=firefox)
[Chrome](https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb)
[Edge](https://microsoftedge.microsoft.com/addons/detail/bitwarden-password-manage/jbkfoedolllekgbhcbcoahefnbanhhlh)
[Opera](https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb)
[Brave](https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb?browser=brave)

## **[Mission Center](https://flathub.org/apps/io.missioncenter.MissionCenter)**

:::details Useful and intuitive system resources monitor that accurately displays informations including CPU, GPU, RAM, processes, among others.
![Mission Center Demo](/assets/editors-choice/mission-center-demo.png)
:::

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub io.missioncenter.MissionCenter
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub io.missioncenter.MissionCenter
```

:::

## **[Obsidian](https://flathub.org/apps/md.obsidian.Obsidian)**

::: details Obsidian is a powerful markdown note-taking app available across different platforms. Obsidian supports custom theming, sync (paid), and publishing services. Write everything that is useful or that can be useful down and start building your second brain!
![Obsidian Demo](/assets/editors-choice/obsidian-demo.png)
:::

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub md.obsidian.Obsidian
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub md.obsidian.Obsidian
```

:::

## **[Scrcpy](https://github.com/Genymobile/scrcpy)**

==From Scrcpy's GitHub:== "This application mirrors Android devices (video and audio) connected via USB or TCP/IP and allows control using the computer's keyboard and mouse. It does not require root access or an app installed on the device. It works on Linux, Windows, and macOS."

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf copr enable zeno/scrcpy && sudo dnf install scrcpy
```

@tab ::devicon:archlinux:: Arch

```bash
pacman -S scrcpy
```

@tab ::devicon:debian:: Debian/Ubuntu

Install the .tar.gz file from the link above

:::

## **[Vesktop](https://flathub.org/apps/dev.vencord.Vesktop)**

Discord with screen sharing and audio support, as well as Vencord inbuilt.

==If you do not care about Discord Rich Presence (DRP), proceed with the Flatpak installation.==

==If you do want DRP, check out [Vesktop’s Github Releases](https://github.com/Vencord/Vesktop/releases) and download the package for your respective distribution.==

:::tabs
@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub dev.vencord.Vesktop
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub dev.vencord.Vesktop
```

:::

## **[Waydroid](https://docs.waydro.id/usage/install-on-desktops)**

Run Android on Linux!

Find out about installation details on the link above
:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install waydroid
```

@tab ::devicon:archlinux:: Arch (AUR)

```bash
yay -S waydroid
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install curl ca-certificates -y
# Download the repo setup script, review it, then run it
# (safer than piping a remote script straight into sudo bash)
curl -o waydroid-setup.sh https://repo.waydro.id
less waydroid-setup.sh
sudo bash waydroid-setup.sh
sudo apt install waydroid -y
```

:::

## **[Gradia](https://flathub.org/en/apps/be.alexandervanhee.gradia)**

:::details Screenshot application with annotation modes including text, arrow, and censor
![Gradia Demo](/assets/editors-choice/gradia-demo.png)
:::

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub be.alexandervanhee.gradia
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub be.alexandervanhee.gradia
```

:::

## **[Kooha](https://flathub.org/apps/io.github.seadve.Kooha)**

:::details Simple and elegant screen recorder for Wayland.
![Kooha Demo](/assets/editors-choice/kooha-demo.png)
:::

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub io.github.seadve.Kooha
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub io.github.seadve.Kooha
```

:::

## **[RClone Manager](https://flathub.org/apps/io.github.zarestia_dev.rclone-manager)**

:::details Graphical interface for managing rclone cloud storage configurations and transfers.
![RClone Manager Demo](/assets/editors-choice/rclone-manager-demo.png)
:::

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub io.github.zarestia_dev.rclone-manager
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub io.github.zarestia_dev.rclone-manager
```

:::

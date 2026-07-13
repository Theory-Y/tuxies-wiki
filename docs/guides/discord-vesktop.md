---
title: Discord & Vesktop
createTime: 2025/05/29 08:29:45
permalink: /guides/discord-vesktop/
tags:
  - Beginner
  - Apps
contributors:
  - aier
  - Lunear
---

## **[Discord](https://flathub.org/apps/com.discordapp.Discord)**

Discord messenger. Join servers and chat with friends!

:::tabs
@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub com.discordapp.Discord
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub com.discordapp.Discord
```

:::

Screen sharing does not work on Wayland because Discord uses an outdated electron version. For that, you may want to check out Vesktop or install Xwayland Video Bridge.

[Vesktop](#vesktop) supports video and audio sharing out of the box and has Vencord tweak integrated. It is the editors’ preferred way to use Discord.

### [Vencord](https://vencord.dev/download/)

A Discord mod (not affiliated with Discord) that allows for theming and cool features.

**Very easy installation. Just paste this line in the terminal to run and set up the installer:**

```bash
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
```

:::warning Good practice to inspect scripts before you run them!
:::

### Discord Rich Presence (DRP)

Flatpak is a sandbox, you need a few more steps to set up Discord Rich Presence

:::tabs

@tab DRP for Non-Flatpak Apps

```bash
mkdir -p ~/.config/user-tmpfiles.d
echo 'L %t/discord-ipc-0 - - - - app/com.discordapp.Discord/discord-ipc-0' > ~/.config/user-tmpfiles.d/discord-rpc.conf
systemctl --user enable --now systemd-tmpfiles-setup.service
```

@tab DRP for Flatpak Apps
Not Recommended, find more info in the GitHub Link

:::

## **[Vesktop](https://flathub.org/apps/dev.vencord.Vesktop)**

Discord with screen sharing and audio support, as well as Vencord inbuilt.

We recommend installing the native versions with the commands below or via [Vesktop’s Github Releases](https://github.com/Vencord/Vesktop/releases) for all features (namely Rich Presense) to work out of the box.

:::tabs
@tab ::devicon:fedora:: Fedora (Terra)

```bash
sudo dnf install vesktop
```

@tab ::devicon:archlinux:: Arch (AUR)

Via an AUR helper such as `yay` — package [`vesktop-bin`](https://aur.archlinux.org/packages/vesktop-bin):

```bash
yay -S vesktop-bin
```

:::

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

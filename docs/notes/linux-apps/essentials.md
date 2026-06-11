---
title: Essentials
createTime: 2025/05/29 08:29:45
permalink: /linux-apps/essentials/
contributors:
  - aier
  - Lunear
---

## **[Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal)**

GUI to modify Flatpak permissions

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub com.github.tchx84.Flatseal
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub com.github.tchx84.Flatseal
```

:::

## **[btrfs-assistant](https://gitlab.com/btrfs-assistant/btrfs-assistant)**

A simple GUI for managing snapshots on the `BTRFS` filesystem, built on top of `snapper`. On `BTRFS`, snapshots are near-instant and preserve SELinux labels — no permissive mode and no relabeling needed.

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install btrfs-assistant snapper python3-dnf-plugin-snapper
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt-get install btrfs-assistant snapper
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S btrfs-assistant snapper
```

:::

:::tip Setting up snapshots
For the full walkthrough — configuring timeline snapshots, taking your first snapshot, and restoring when needed — see [Create snapshots/backups](/linux-guides/fedora/#create-snapshots-backups-for-your-computer) in the Fedora guide.
:::

## **[Timeshift](https://github.com/linuxmint/timeshift)**

Create snapshots of your computer that you can roll back to. Best suited to non-`BTRFS` systems such as `ext4`.

:::tip Using BTRFS?
If your system uses the `BTRFS` filesystem (Fedora's default), we recommend [btrfs-assistant](#btrfs-assistant) above instead. BTRFS snapshots are faster, more reliable, and preserve SELinux labels, avoiding relabeling issues entirely.
:::

::::steps

- **Installation**

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install timeshift
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt-get install timeshift
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  sudo pacman -S timeshift
  ```

  :::

- **Recovering from SELinux label issues after a restore**

  If you are restoring snapshots in RSYNC mode on a SELinux-enforcing distro (e.g. Fedora, RHEL, Rocky), you may encounter file mislabeling errors or "permission denied" errors on first boot. Trigger a full filesystem relabel and reboot — be patient, the relabel pass takes a few minutes.

  ```bash
  sudo touch /.autorelabel
  ```

  ```bash
  reboot
  ```

  :::warning If the restored system fails to boot under enforcing SELinux, interrupt GRUB and append `enforcing=0` to the kernel command line for that one boot only. This lets `/.autorelabel` complete, after which the system will reboot itself into a normally-enforcing state.
  :::

::::

## **[Gparted](https://gparted.org/download.php)**

Disk partitioning tool.

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install gparted
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S gparted
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt-get install gparted
```

:::

## **VS Code**

:::tabs
@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub com.visualstudio.code
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub com.visualstudio.code
```

:::

### **[VS Code Non-Flatpak Download](https://code.visualstudio.com/Download)**

If you have to avoid limitations imposed by using a Flatpak wrapper of VS Code, check the downloads methods below.

:::tabs

@tab ::devicon:fedora:: Fedora
Download .rpm file from link above

@tab ::devicon:archlinux:: Arch (Code - OSS)

```bash
sudo pacman -S code
```

@tab ::devicon:debian:: Debian/Ubuntu
Download .deb file from link above

:::

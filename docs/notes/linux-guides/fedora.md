---
title: Fedora Guide
createTime: 2025/05/29 08:29:45
permalink: /linux-guides/fedora/
contributors:
  - aier
---

:::tip Why Fedora?
Fedora offers a high-quality out-of-the-box experience while remaining highly flexible. It is stable, yet it has up-to-date and cutting edge packages.
:::

## **Installation**

::::steps

- **Install Fedora onto your machine**

  :::warning TODO: A video step-by-step installation.
  :::
  - [Installing Fedora in the Simplest Possible Way](https://itsfoss.com/install-fedora/) by Abhishek Prakash from It's FOSS.

  - [NVIDIA GPU Driver Installation](https://docs.fedoraproject.org/en-US/gaming/drivers/) by the Fedora Docs.

  - [Fedora on MacBook](https://asahilinux.org/fedora/) by Official Asahi Linux.

- **Update system**

  :::tabs
  @tab Terminal

  ```bash
  sudo dnf update -y
  ```

  @tab GUI (Gnome Software)
  ![Gnome Software Update Button](/assets/fedora/gnome-software-update.svg)
  :::

- **Update your firmware**

  Firmware updates can fix real bugs (battery life, sleep problems, dodgy webcams).

  :::tabs
  @tab Terminal

  ```bash
  fwupdmgr refresh --force
  fwupdmgr get-updates
  fwupdmgr update
  ```

  @tab GUI (Gnome Software)
  Firmware updates show up next to your normal updates in the ==Updates== tab.

  ![The Updates tab in Gnome Software](/assets/fedora/gnome-software-updates-tab.png)
  :::

- **Reboot**

  ```bash
  reboot
  ```

::::

## **Other Repositories**

Fedora leaves out a fair amount of software for legal, licensing, and philosophical reasons. You may consider the repositories below.

### **RPM Fusion**

[RPM Fusion](https://rpmfusion.org/) carries video and audio formats, NVIDIA drivers, and plenty more. Most readers will want this one.

```bash
sudo dnf install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

:::note Gnome Software's ==Third Party Repositories== toggle is not the same thing. It only adds a couple of narrow slices of RPM Fusion, such as the NVIDIA driver and Steam.
:::

### **Terra**

[Terra](https://terrapkg.com/) is a community package repository for Fedora by Fyra Labs. 2000+ propietary/nonfree packages that Fedora doesn't ship by default can be found in Terra.

```bash
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
```

Once enabled, you can install its packages with the regular `dnf` command.

## **Flathub (Flatpaks)**

Many Linux apps are distributed as Flatpaks, a universal package format that works on every distro.

Set up the largest Flatpak repository here: [Flatpak Setup](/introduction/flatpak-setup/).

## **Multimedia Codecs**

Fedora ships without several common video and audio formats, so some videos refuse to play and some files won't open. Pull these from RPM Fusion:

::::steps

- **Install codecs**
  :::warning Enable [RPM Fusion](#rpm-fusion) first, or these commands will have nothing to fetch.
  :::

  ```bash
  sudo dnf swap ffmpeg-free ffmpeg --allowerasing
  sudo dnf group upgrade multimedia
  sudo dnf group upgrade core
  ```

- **Reboot once it finishes**

  ```bash
  reboot
  ```

### **Hardware video acceleration**

Fedora's stock drivers cannot process two common video formats (H.264 and HEVC) on your graphics chip. To avoid draining your battery and stutter on high-resolution video:

::::steps

- **Install drivers**
  :::tabs

  @tab ::simple-icons:amd:: AMD

  ```bash
  sudo dnf install mesa-va-drivers-freeworld
  ```

  @tab ::simple-icons:intel:: Intel

  ```bash
  sudo dnf install intel-media-driver
  ```

  @tab ::simple-icons:nvidia:: NVIDIA

  ```bash
  sudo dnf install libva-nvidia-driver
  ```

  :::

- **Reboot**
  ```bash
  reboot
  ```

## **Create snapshots/backups** for your computer

We'll be using `btrfs-assistant`, a simple GUI for managing snapshots. It sits on top of `snapper` and uses Fedora's default `BTRFS` filesystem, so snapshots are quick and preserve SELinux labels — no permissive mode and no relabeling needed.

:::tip Prefer the terminal?
Every step below is also available through the `snapper` CLI if you'd rather not use the GUI.
:::

::::steps

- **Install `btrfs-assistant`**

  ```bash
  sudo dnf install btrfs-assistant snapper python3-dnf-plugin-snapper
  ```

- **Set up snapshots**

  Open `btrfs-assistant` and go to the ==Snapper Settings== tab. Click ==New==, set ==Backup path== to `/`, give it a ==Config name==, then click ==Save==.

  ![Creating a new Snapper config in btrfs-assistant](/assets/fedora/btrfs-assistant-creating-new-settings.png)

  With the config selected, tick ==Enable timeline snapshots== and choose how many to keep under ==Snapshot Retention==.

  ![Setting the number of snapshots to keep under Snapshot Retention](/assets/fedora/btrfs-assistant-number-of-snapshots.png)

  Then, under ==systemd Unit Settings==, tick ==Snapper timeline enabled== and ==Snapper cleanup enabled== and click ==Apply systemd changes==.

  ![Enabling the Snapper timeline and cleanup systemd units](/assets/fedora/btrfs-assistant-enable-timeline-systemd.png)

  :::details What these three `systemd` options do

  These `systemd` timers automate your snapshots.

  **Snapper timeline** runs per the schedule you set, giving you a steady stream of recent restore points with no effort.

  **Snapper cleanup** runs periodically and deletes old snapshots so they never fill the disk using the limits you set.

  **Snapper boot** takes a snapshot every time you turn your computer on. We leave this one off — your timeline snapshots already cover you; this would fill your snapshot limit much faster.

  :::

- **Take your first snapshot**

  Switch to the ==Snapper== tab, select your config, and click ==New== to take a manual snapshot. Give it a description like `clean install`.

  ![Taking a manual snapshot in btrfs-assistant](/assets/fedora/btrfs-assistant-creating-new-snapshot.png)

- **Restore a snapshot when needed**

  On the ==Snapper== tab, open the ==Browse/Restore== view, select the snapshot you want, and click ==Restore==. Reboot once it completes.

  :::note Want to boot straight into a snapshot when your system won't start? [`grub-btrfs`](https://github.com/Antynea/grub-btrfs) adds a snapshots submenu to `GRUB` for exactly that. It has no Fedora package and must be built from source, so follow its README if you'd like to set it up.
  :::

::::

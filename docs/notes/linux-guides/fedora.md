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

  - [NVIDIA Drivers Guide](https://rpmfusion.org/Howto/NVIDIA) by Official RPM Fusion.

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

- **Reboot**

  ```bash
  reboot
  ```

::::

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

  :::tip I recommend keeping 3–5 snapshots at a time.
  :::

- **Take your first snapshot**

  Switch to the ==Snapper== tab, select your config, and click ==New== to take a manual snapshot. Give it a description like `clean install`.

  ![Taking a manual snapshot in btrfs-assistant](/assets/fedora/btrfs-assistant-creating-new-snapshot.png)

- **Restore a snapshot when needed**

  On the ==Snapper== tab, open the ==Browse/Restore== view, select the snapshot you want, and click ==Restore==. Reboot once it completes.

  :::note Want to boot straight into a snapshot when your system won't start? [`grub-btrfs`](https://github.com/Antynea/grub-btrfs) adds a snapshots submenu to `GRUB` for exactly that. It has no Fedora package and must be built from source, so follow its README if you'd like to set it up.
  :::

::::

## **Further customisation**

From this point on, customisation for your Fedora installation would mainly be based on the DE that you are using.

- [Gnome Guide](/linux-guides/gnome/)

---
title: Fixing a Missing Windows Boot Entry
createTime: 2026/08/24 12:00:00
permalink: /guides/fix-missing-windows-boot-entry/
tags:
  - Advanced
  - efibootmgr
  - Dual-Boot
  - Fixes
---

:::info What this guide covers
Windows ==vanished from your boot menu== on a dual-boot machine — usually right after a Windows Update. We'll find out why and put it back, all from Linux, with ==no Windows install USB needed==.
:::

:::warning You will be deleting boot files and editing firmware entries as root.
Do the backup step before anything else, and read every command before running it. Deleting the wrong folder can leave an OS unbootable.
:::

## **Why Windows Disappears**

Your firmware keeps a small list of boot entries. Think of each one as a ==bookmark==: "Windows Boot Manager lives on partition X, in the file `\EFI\Microsoft\Boot\bootmgfw.efi`".

The files those bookmarks point to live on the ==EFI System Partition (ESP)== — a small partition that every OS on the disk shares. Two things break this design:

1. If the ==file== a bookmark points to disappears, many firmwares (ASUS included) quietly hide the entry from the boot menu.
2. If the ESP ==fills up==, nothing can write new boot files to it.

The classic failure combines both. Old Linux installs leave their kernels on the shared ESP forever (wiping a distro's partitions does ==not== clean the ESP), until it is full. Then a Windows Update tries to replace `bootmgfw.efi`: it deletes the old copy, cannot write the new one, and gives up. Windows is gone from the boot menu — but only from the menu.

:::tip A "missing" OS usually isn't gone.
Windows itself is untouched, and it keeps a recovery copy of its boot manager at `C:\Windows\Boot\EFI\`. We only need to restore one small file and one bookmark.
:::

::::details How to confirm this happened (Windows' own logs)
Windows logs the failed boot-file update in `C:\Windows\Logs\CBS\CbsPersist_*.log`. Search the logs for `bootmgfw`, `BFSVC`, or `0x80070070` (the "disk full" error code). A real example:

```
04:12:16  BFSVC: 'BfspCheckFreeSpace failed: 0x80070070. This error is ignored.'
04:12:48  Error HRESULT_FROM_WIN32(ERROR_DISK_FULL) ... BfsvcInstaller::CommitChanges
04:12:53  Boot File Servicing (BFSVC) Installer failed ... A rollback will be initiated
```

The rollback restores Windows itself, but not the file it already deleted from the ESP.
::::

## **Diagnosing**

::::steps

- **Check the firmware's boot entries**

  ```bash
  sudo efibootmgr -v
  ```

  A healthy Windows entry shows a file path ending in `bootmgfw.efi`. If the entry is ==missing==, or shows `VenHw(...)` instead of a file path, it is orphaned — the file it pointed to is gone.

- **Find your ESP(s)**

  ```bash
  lsblk -o NAME,SIZE,FSTYPE,PARTTYPENAME,MOUNTPOINTS
  ```

  Look for partitions marked ==EFI System==.

  :::warning You may have more than one ESP.
  Some installs create a second ESP instead of reusing the first. Windows only services the one ==it== lives on — that is the one to inspect and repair. Your distro's own ESP is usually already mounted at `/boot/efi`.
  :::

- **Mount the ESP and look inside**

  Replace `/dev/nvme0n1p1` with your ESP throughout this guide.

  ```bash
  sudo mkdir -p /mnt/esp
  sudo mount /dev/nvme0n1p1 /mnt/esp
  ls /mnt/esp/EFI/Microsoft/Boot/bootmgfw.efi
  df -h /mnt/esp
  ```

  If `bootmgfw.efi` is missing and `df` shows the partition (nearly) ==100% full==, you have this exact problem — carry on below.

- **Confirm Windows is still intact**

  Replace `/dev/nvme0n1p3` with your Windows partition (usually the biggest NTFS one).

  ```bash
  sudo mkdir -p /mnt/win
  sudo mount -o ro /dev/nvme0n1p3 /mnt/win
  ls /mnt/win/Windows/Boot/EFI/bootmgfw.efi
  ```

  If that file lists fine, everything you need for the repair is already on your disk.

::::

## **The Fix**

::::steps

- **Back up the ESP**

  ```bash
  sudo tar -C /mnt/esp -cf ~/esp-backup-$(date +%F).tar \
      --exclude='*.img' --exclude='vmlinuz-*' .
  ```

  This archives the loaders and configs (skipping bulky kernel images) so any deletion below is reversible.

- **Free up space**

  List what is on the ESP and delete only the leftovers of OSes that ==no longer exist== — old distro folders under `EFI/`, stray kernels (`vmlinuz-*`), and initramfs images (`*.img`) in the ESP root.

  ```bash
  ls /mnt/esp /mnt/esp/EFI
  sudo rm -rf /mnt/esp/EFI/<dead-os-folder>
  df -h /mnt/esp
  ```

  :::warning Never delete `EFI/Microsoft`, `EFI/Boot`, or the folder of a distro you still use.
  If you are unsure about a folder, leave it — you only need enough free space (~100 MB) for the next step.
  :::

- **Put the Windows boot manager back**

  ```bash
  sudo cp /mnt/win/Windows/Boot/EFI/bootmgfw.efi /mnt/esp/EFI/Microsoft/Boot/bootmgfw.efi
  sudo cp /mnt/win/Windows/Boot/EFI/bootmgr.efi  /mnt/esp/EFI/Microsoft/Boot/bootmgr.efi
  ```

  :::info This is the same source Microsoft's own repair tool (`bcdboot`) copies from.
  :::

- **Recreate the boot entry**

  First remove any orphaned entries you found while diagnosing (replace `0000` with each orphan's number):

  ```bash
  sudo efibootmgr -B -b 0000
  ```

  Then create a fresh Windows entry (`-d` is the disk, `-p` the ESP's partition number):

  ```bash
  sudo efibootmgr -c -d /dev/nvme0n1 -p 1 -L "Windows Boot Manager" \
      -l '\EFI\Microsoft\Boot\bootmgfw.efi'
  ```

  Finally set the boot order with your entry numbers, Linux first:

  ```bash
  sudo efibootmgr -o 0004,0002
  ```

- **Optional: show Windows in the GRUB menu**

  Enable `os-prober` so GRUB finds Windows, then regenerate the menu:

  ```bash
  echo 'GRUB_DISABLE_OS_PROBER=false' | sudo tee -a /etc/default/grub
  ```

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo grub2-mkconfig -o /boot/grub2/grub.cfg
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo update-grub
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  ```

  :::

- **Unmount and reboot**

  ```bash
  sudo umount /mnt/esp /mnt/win
  ```

  Windows should be back in the firmware menu and in GRUB. Once booted into Windows, ==run Windows Update again== — the update that broke everything rolled itself back and will now install cleanly.

::::

## **If Windows Duplicates Its Entry**

After booting Windows once, you may see ==two or three== "Windows Boot Manager" entries. This is expected: the entry we made with `efibootmgr` lacks a data blob Windows embeds to recognise its own entry, so Windows registers a fresh one. All of them point at the same file.

Run `sudo efibootmgr -v` and keep the entry with the long extra data blob (containing `BCDOBJECT`) — that is the one Windows made and will keep recognising. Delete the rest with `sudo efibootmgr -B -b <number>`. It will not duplicate again.

## **Preventing It**

- ==Clean the ESP when you remove a distro.== Deleting its partitions leaves its boot files behind — mount the ESP and delete its `EFI/<name>` folder, kernels, and `loader/entries/*` yourself.
- ==Keep at least ~100 MB free== on the ESP Windows uses. Boot-manager updates need room to stage files, and fail destructively without it.
- ==If you have two ESPs, note which is which.== Windows only services its own; your distro only writes to the one mounted at `/boot/efi`.

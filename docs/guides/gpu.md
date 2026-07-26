---
title: GPU Guide
createTime: 2026/07/13 12:00:00
permalink: /guides/gpu/
tags:
  - Intermediate
  - GPU
  - Cardwire
---

:::info What this guide covers
This guide will help you set up your GPU on linux.

First, we will install ==drivers== for AMD or NVIDIA.

Then for laptops — ==Cardwire== — a tool that lets a computer with two graphics chips switch between them on the fly, with no reboot, to save battery or gain power when you need it.
:::

:::warning Tested on Fedora only
Every step here has been tested on ==Fedora==. The ideas carry over to other distros, but the exact commands may differ. If you run another distro and want to help, ==contributions are very welcome== — see [Contributions](/contributions/).
:::

::::details Quick append
Once Cardwire is installed, this is the whole recommended setup in one place.

:::tabs
@tab Apply (Universal)

```bash
cardwire config battery-auto-switch true
cardwire config battery-auto-switch-mode hybrid
cardwire config save
```

@tab Apply (NVIDIA-only)

```bash
cardwire config battery-auto-switch true
cardwire config battery-auto-switch-mode hybrid
# NVIDIA laptops only — stops the dedicated chip waking up and draining battery
cardwire config experimental-nvidia-block true
cardwire config save
```

@tab Reset

```bash
cardwire config battery-auto-switch false
cardwire config experimental-nvidia-block false
cardwire config save
```

:::

::::

## **Installing drivers**

:::::tabs

@tab ::simple-icons:nvidia:: NVIDIA (Fedora)

NVIDIA's official driver is not in Fedora's default repositories. It lives in ==RPM Fusion==, a community repository. Enable it, then install the driver.

::::steps

- **Enable RPM Fusion**

  This one command adds both the free and non-free RPM Fusion repositories:

  ```bash
  sudo dnf install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  ```

- **Install the driver**

  ```bash
  sudo dnf install akmod-nvidia
  ```

  This also builds a kernel module tailored to your system, so it rebuilds itself automatically after future kernel updates.

  :::warning Give the module time to build before rebooting — usually ==around five minutes==. Reboot too early and you may boot to a black screen. You can watch it finish with:

  ```bash
  modinfo -F version nvidia
  ```

  When that prints a version number, the module is ready.
  :::

- **Trust the driver** _(only needed for Secure Boot)_

  Skip this if Secure Boot is off. With Secure Boot on, your computer only loads drivers it already trusts. The NVIDIA driver you just built is brand new, so it is not trusted yet — it refuses to load and you would fall back to the open-source drivers.

  Tell your computer to trust it by importing the key Fedora made for the driver:

  ```bash
  sudo mokutil --import /etc/pki/akmods/certs/public_key.der
  ```

  You will be asked to make up a password. It will be used ==once== on the very next reboot; pick something simple.

  On the next reboot only, a blue screen called ==MOK Manager== appears. Choose `Enroll MOK`, then `Continue`, then `Yes`, and type the password you just set.

  If you miss the screen, the computer boots as normal — just run the command again to get another go.

- **Wait, then reboot**

  Once the module has finished building, reboot to load the new driver. On Secure Boot, this is also the reboot where the ==MOK Manager== screen appears:

  ```bash
  reboot
  ```

:::note More detail on Fedora's NVIDIA setup — including CUDA and codec support — lives in the [NVIDIA GPU Driver Installation](https://docs.fedoraproject.org/en-US/gaming/drivers/) guide by the Fedora Docs.
:::

::::

@tab ::simple-icons:nvidia:: NVIDIA (Debian/Ubuntu)

:::info Contribution appreciated
NVIDIA driver setup for Debian/Ubuntu has not been written yet. If you run it and want to help, ==contributions are very welcome== — see [Contributions](/contributions/).
:::

@tab ::simple-icons:nvidia:: NVIDIA (Arch)

:::info Contribution appreciated
NVIDIA driver setup for Arch has not been written yet. If you run it and want to help, ==contributions are very welcome== — see [Contributions](/contributions/).
:::

@tab ::simple-icons:amd:: AMD

Good news — there is nothing to install. The open-source ==Mesa== AMD drivers ship by default on every major distro and stay up to date with your system updates. Your card already works.

:::::

## **Cardwire**

==Cardwire== is a GPU manager for laptops that have two graphics chips. It is the modern successor to the older `supergfxctl` tool.

It can block or unblock a GPU ==without a reboot or logout==.

:::warning Before you start

- Cardwire needs ==Wayland== — it does not work on X11. Fedora's default GNOME session is already Wayland, so you are likely fine.
- It is ==experimental==. Expect the occasional rough edge.
- Switching to a two-GPU mode requires ==exactly two graphics chips==, which is the typical laptop setup.

:::

### **Installing Cardwire**

::::tabs

@tab ::devicon:fedora:: Fedora

Cardwire is packaged for Fedora in the ==Terra== repository. If you have not enabled Terra yet, follow the one-command setup in the [Fedora Guide](/linux-guides/fedora/#terra-repository) first.

With Terra enabled, install Cardwire and turn on its background service:

```bash
sudo dnf install cardwire
sudo systemctl enable cardwired --now
# The "--now" flag starts the service immediately
# as well as enabling it on boot. No reboot needed.

```

@tab ::devicon:debian:: Debian/Ubuntu

:::info Contribution appreciated
Cardwire packaging for Debian/Ubuntu has not been documented yet. If you can help, ==contributions are very welcome== — see [Contributions](/contributions/).
:::

@tab ::devicon:archlinux:: Arch

:::info Contribution appreciated
Cardwire packaging for Arch has not been documented yet. If you can help, ==contributions are very welcome== — see [Contributions](/contributions/).
:::

::::

### **Basic commands**

Three commands cover everyday use:

```bash
cardwire list              # show every GPU, its ID, and whether it is blocked
cardwire get               # show the current mode
cardwire set integrated    # switch mode (integrated | hybrid | manual | smart)
```

A mode change applies to ==newly launched apps==. Anything already open keeps the GPU it started with.

Here is what each mode does:

| Mode         | What it does                                                                                        |
| ------------ | --------------------------------------------------------------------------------------------------- |
| `integrated` | Blocks the dedicated GPU. Longest battery life — everything runs on the built-in graphics.          |
| `hybrid`     | Unblocks the dedicated GPU. Both chips available; apps can use the powerful one.                    |
| `smart`      | Blocks the dedicated GPU by default, but watches apps as they launch and lets approved ones use it. |
| `manual`     | The default, safe mode. You block and unblock each GPU yourself.                                    |

In `manual` mode you control a single GPU directly by its ID (find IDs with `cardwire list`):

```bash
cardwire gpu 1 --block     # block GPU 1
cardwire gpu 1 --unblock   # unblock GPU 1
cardwire gpu 1 --lsof      # see what is currently using GPU 1
```

### **Recommended setup**

We recommend setting up ==battery-based switching== to automatically use the built-in graphic while on battery and to use the dGPU when plugged in. This maximises battery life when not plugged in and gives you full performance when plugged.

```bash
cardwire config battery-auto-switch true
cardwire config battery-auto-switch-mode hybrid
cardwire config save
```

:::tip
`battery-auto-switch-mode` is the mode Cardwire returns to when plugged in. On battery it always drops to `integrated` to save power. Leaving it on `hybrid` means: full power on the charger, quiet and efficient off it.
:::

### **NVIDIA**: stop the dedicated chip waking up

:::details Tech details

If your dedicated chip is an ==NVIDIA card==, it's worth turing on `experimental-nvidia-block`.

Certain apps (particularly Vulkan and GTK on Gnome) — can quietly wake the dedicated chip even while it is blocked. This drains your battery for nothing.

`experimental-nvidia-block` makes sure that your NVIDIA card doesn't get waken up in integrated mode, and Cardwire's authors recommend it for NVIDIA laptops.
:::

```bash
cardwire config experimental-nvidia-block true
cardwire config save
```

:::warning
This only works reliably on the standard laptop setup — ==exactly two chips==: the built-in graphics plus one NVIDIA card.
:::

<!-- TEMPORARILY HIDDEN — pending verification. Live measurements (2026-07-25) suggest the
dominant overnight drain was a touchpad wakeup interrupt storm, not the dGPU staying in D0;
the dGPU's real contribution is unconfirmed until an A/B test. Re-publish (rewritten) once
tonight's numbers are in.

## **Fixing Battery Drain** during sleep (NVIDIA dGPUs)

Battery drain overnight? Laptop warm when suspended?

Modern laptops no longer use S3 deep sleep, instead, they use ==modern standby== (`s2idle`), where each part of the computer is expected to power itself down. The NVIDIA driver only does this if you ask it to.

Check which sleep style your laptop uses:

```bash
cat /sys/power/mem_sleep
# [s2idle]  <-- this fix is for you
# [deep]    <-- you have S3 sleep; this fix does not apply
```

::::steps

- **Tell the NVIDIA driver to power down during sleep**

  Create one small config file:

  ```bash
  sudo tee /etc/modprobe.d/nvidia-pm.conf <<'EOF'
  options nvidia NVreg_EnableS0ixPowerManagement=1 NVreg_TemporaryFilePath=/var/tmp
  EOF
  ```

  :::warning Do ==not== use `NVreg_PreserveVideoMemoryAllocations=1` on a modern-standby (`s2idle`) laptop. That option is meant for the old S3 sleep style — on `s2idle` machines it can ==freeze the laptop the moment it tries to sleep==. Then a force shutdown (holding the power button for 10s) is needed.
  :::

- **Reboot**

  The setting is read when the driver loads, so a reboot is required:

  ```bash
  reboot
  ```

- **Verify it worked**

  Put the laptop to sleep for ~5 minutes, check:

  ```bash
  journalctl -b | grep "Power state changed"
  ```

  If you see the NVIDIA dGPU reaching `D3Cold` during the sleep interval, then the dGPU drain has been fixed.

::::

::::details Why this happens (technical detail)

- During `s2idle`, the kernel briefly wakes every PCI device to `D0` (full power) on the way into sleep. The NVIDIA driver is then responsible for saving its state and dropping the card back to `D3`.
- Without `NVreg_EnableS0ixPowerManagement=1`, the driver skips that step and the card ==sits in `D0` for the entire sleep== — roughly 7% (5W) battery per hour on an RTX 4060, and a warm chassis by morning.
- With the option on, the driver copies video memory into system RAM (when usage is under the `S0ixPowerManagementVideoMemoryThreshold`, 256 MB by default) and powers the card down for the duration of standby.
- `NVreg_PreserveVideoMemoryAllocations=1` instead saves ==all== video memory to disk via `nvidia-suspend.service`. An S3-era mechanism that collides with the `s2idle` entry path and can hang the kernel causing a freeze.
- You can watch the card's power state around a sleep cycle with `journalctl -b | grep "Power state changed"` (Cardwire logs these). A brief `D0` right at sleep entry is normal; it should read `D3Cold` once the system is back up.

::::

END TEMPORARILY HIDDEN -->

## **Gnome Extension: Cardwire GPU Toggle**

A Quick Settings toggle to switch between GPU modes using cardwire.

If you already use `battery-auto-switch`, this may be redundant.

[Download Link](https://extensions.gnome.org/extension/9919/cardwire-gpu-toggle/)

![The Cardwire GPU Toggle in the GNOME Quick Settings menu](/assets/gpu/cardwire-gpu-toggle.png)

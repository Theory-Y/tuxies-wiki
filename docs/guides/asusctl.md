---
title: ASUS Laptop Control (asusctl)
createTime: 2026/07/18 12:00:00
permalink: /guides/asusctl/
tags:
  - Intermediate
  - asusctl
  - Power
  - Laptop
---

:::info What this guide covers
This guide sets up ==power management== on ASUS ROG, TUF, and ProArt laptops using `asusctl`.

We'll keep this guide mostly away from the terminal. By the end, you will be able to have your laptop change performance modes based on whether it is plugged in and set battery charge thresholds.
:::

:::warning ASUS ROG / TUF / ProArt laptops only
`asusctl` only works on ASUS laptops (the ==ROG==, ==TUF==, and ==ProArt== lines). On any other laptop these tools will not find your hardware.
:::

::::details Quick append (CLI)
Once `asusctl` is installed (see [below](#installing-asusctl)), this is the whole setup in one place if you prefer the CLI.

:::tabs

@tab Apply

```bash
# turn the background service on
systemctl enable --now asusd

# automatic switching: Balanced when plugged in, Quiet on battery
asusctl profile set -a Balanced
asusctl profile set -b Quiet

# apply a profile to use right now
asusctl profile set Balanced

# stop charging at 80% to preserve long-term battery health
asusctl battery limit 80
```

@tab Reset

```bash
# same profile on AC and battery — undo the automatic switching
asusctl profile set -a Balanced
asusctl profile set -b Balanced

# allow charging back to 100%
asusctl battery limit 100
```

:::

:::warning
EPP is not set via `asusctl`. The throttle-policy → EPP link lives in `/etc/asusd/asusd.ron` as `platform_profile_linked_epp`.

Use ROG Control Center for it, or edit that file `asusd.ron`.
:::

::::

## **Installing asusctl**

`asusctl` comes in two pieces: `asusd` (the background service that actually changes the settings) and ==ROG Control Center== (the graphical app).

Install both, then turn the service on.

::::tabs

@tab ::devicon:fedora:: Fedora (Terra)

[With Terra enabled:](/linux-guides/fedora/#terra)

```bash
sudo dnf install asusctl asusctl-rog-gui
systemctl enable --now asusd.service
```

:::warning Using an old COPR?
The old `lukenukem/asus-linux` COPR is dead. If you added it in the past, remove it (`sudo dnf copr remove lukenukem/asus-linux`, `sudo dnf autoremove` and `sudo dnf remove asusctl asusctl-rog-gui`) so it does not clash with the Terra package.
:::

@tab ::devicon:debian:: Debian/Ubuntu

Follow the ==official build instructions== in the
[OpenGamingCollective/asusctl README](https://github.com/OpenGamingCollective/asusctl).

@tab ::devicon:archlinux:: Arch

`asusctl` is in the official `extra` repository. ROG Control Center is in the AUR:

```bash
sudo pacman -S asusctl
yay -S rog-control-center
systemctl enable --now asusd.service
```

::::

## **Power profiles vs. your desktop's toggle**

`asusctl` uses `power-profiles-daemon` to manage Power Profiles and automatic performance mode switching.

Most desktops and distros should already come and use `power-profiles-daemon`; regardless, below are the steps to set `power-profiles-daemon` as your performance manager:

:::tabs

@tab ::devicon:fedora:: Fedora

Fedora uses `tuned-ppd`; swap it for `power-profiles-daemon` below.

```bash
sudo dnf install power-profiles-daemon
sudo dnf swap tuned-ppd power-profiles-daemon --allowerasing
systemctl enable --now power-profiles-daemon.service
```

@tab ::devicon:debian:: Debian/Ubuntu

Usually already installed. If not:

```bash
sudo apt install power-profiles-daemon
systemctl enable --now power-profiles-daemon.service
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S power-profiles-daemon
systemctl enable --now power-profiles-daemon.service
```

:::

Then turn off your desktop's "automatically switch to Power Saver on battery" option in the settings app so only one thing changes the profile when you unplug.

:::tip

- `asusd` cooperates with `power-profiles-daemon`, so both your Quick Settings toggle and ROG Control Center's ==Platform Profiles== are safe to use.
  - Quick Settings for everyday switching,
  - ROG Control Center for the one-time automatic-switching setup below.

:::

## **Performance Management**

::::info Platform Profile (also Throttle Policy in ROG Control Center)

Your laptop's ==overall power mode==. Platform Profile determines the maximum power budget:

- Increase budget -> fans and chips run hotter; system feels snappier
- Decrease budget -> everything runs cooler, saving battery; system feels slightly slower

:::details

==System Control -> Power Settings -> Platform Profile==

| Profile         | What it does                                                                      |
| --------------- | --------------------------------------------------------------------------------- |
| **Quiet**       | Lowest power, quietest fans. Best for battery life and light work.                |
| **Balanced**    | The middle ground — the everyday default.                                         |
| **Performance** | Full power, fans allowed to ramp. Best for gaming or heavy work while plugged in. |

:::
::::

<!-- TODO image: ROG Control Center System tab — Throttle Policy dropdown -->

::::info Energy Performance Preference (EPP)
Where the Throttle Policy is the total power budget for the whole laptop, ==EPP== controls just the CPU. It nudges the processor toward either ==saving power== or ==going fast==.

You don't necessarily have to toggle this section, but here is the editor's suggestion:

- Balanced Policy -> Balanced Performance
- Performance Policy -> Performance
- Quiet Policy -> Power

:::details

==System Control -> Power Settings -> Platform Profile -> Advanced -> EPP linked to Throttle Policy==

| EPP                    | Definition                        | Behaviour                                            |
| ---------------------- | --------------------------------- | ---------------------------------------------------- |
| **Power**              | Power saving                      | CPU stays slow to save the most battery              |
| **BalancePower**       | Balanced, leaning to power saving | CPU speeds up only when it really needs to           |
| **BalancePerformance** | Balanced, leaning to performance  | CPU speeds up readily, but still eases off when idle |
| **Performance**        | Performance                       | CPU jumps to full speed quickly                      |

:::
::::

<!-- TODO image: ROG Control Center — linked-EPP toggle + per-profile EPP dropdowns -->

### **Automate: performance plugged-in, power-saving on battery**

==System Control -> Power Settings -> Platform Profile -> Advanced -> Throttle Policy for power state==

:::steps

- **Turn on "Throttle Policy on Battery"**

  Set its dropdown to ==Quiet==. It would use the Quiet policy when you unplug.

- **Turn on "Throttle Policy on AC"**

  Set its dropdown to ==Balanced== (or Performance if you prefer maximum power for a hotter system).

:::

<!-- TODO image: ROG Control Center — "Throttle Policy for power state" AC/battery toggles -->

:::tip
Verify if it actually worked by heading back to the ROG Control Center dashboard:

Plug and unplug to see if the ==Platform Profile== has changed.
:::

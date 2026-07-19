---
title: ASUS Laptop Control (asusctl)
createTime: 2026/07/18 12:00:00
permalink: /guides/asusctl/
tags:
  - Intermediate
  - asusctl
  - Power
  - Laptop
draft: true
---

:::info What this guide covers
This guide sets up ==power management== on ASUS ROG, TUF, and ProArt laptops using `asusctl`.

We'll keep this guide mostly away from the terminal. By the end, you will be able to have your laptop change performance modes based on whether it is plugged in and set battery charge thresholds.
:::

:::warning ASUS ROG / TUF / ProArt laptops only
`asusctl` only works on ASUS laptops (the ==ROG==, ==TUF==, and ==ProArt== lines). On any other laptop these tools will not find your hardware.
:::

## **Installing asusctl**

`asusctl` comes in two pieces: `asusd` (the background service that actually changes the settings) and ==ROG Control Center== (the graphical app).

Install both, then turn the service on.

::::tabs

@tab ::devicon:fedora:: Fedora (Terra)

[With Terra enabled:](/linux-guides/fedora/#terra-repository)

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

:::warning One power manager at a time
Your desktop already has a power switch (the ==Power Saver / Balanced / Performance== toggle in GNOME or KDE Quick Settings). It and `asusctl` write to the ==same== hardware setting, so if both try to control it they fight — you set Performance in one and the other flips it back. On Fedora the fix is to run `power-profiles-daemon` as the single owner:

```bash
sudo dnf swap tuned-ppd power-profiles-daemon --allowerasing
systemctl enable --now power-profiles-daemon.service
```

Modern `asusd` works together with that toggle, so your desktop switch keeps working. More on this in [the last section](#power-profiles-vs-your-desktop-s-toggle).
:::

:::danger Reviewed up to this point.
:::

## **Platform Profiles (Throttle Policy)**

A ==Platform Profile== (ROG Control Center calls it ==Throttle Policy==) is your laptop's overall power
mode. Think of it as one big dial: turn it up and the fans spin faster, the chips run hotter and
stronger; turn it down and everything goes quiet and cool to save battery.

There are three you will use:

| Profile         | What it does                                                                      |
| --------------- | --------------------------------------------------------------------------------- |
| **Quiet**       | Lowest power, quietest fans. Best for battery life and light work.                |
| **Balanced**    | The middle ground — the everyday default.                                         |
| **Performance** | Full power, fans allowed to ramp. Best for gaming or heavy work while plugged in. |

Open ==ROG Control Center== and pick one from the ==Throttle Policy== dropdown on the System tab. That
is the whole job — the change takes effect immediately.

:::tip Want the terminal instead?
`asusctl` has a CLI too. Check your current profile with `asusctl profile -p`, and run
`asusctl profile --help` to see how to change it. We point you at `--help` rather than listing flags
because they shift between versions — the app is the reliable path.
:::

<!-- TODO image: ROG Control Center System tab — Throttle Policy dropdown -->

## **Energy Performance Preference (EPP)**

Where the Throttle Policy is the big dial for the whole laptop, ==EPP== is a smaller dial just for the
CPU. It nudges the processor toward either ==saving power== or ==going fast== inside whatever profile you
picked. You rarely need to touch it by hand — and you should not have to, because of one handy switch.

In ROG Control Center, turn on ==Energy Performance Preference linked to Throttle Policy==. With it on,
each profile brings its own matching EPP automatically: choose Performance and the CPU leans fast,
choose Quiet and it leans efficient. Set it once and forget it.

::::details The detail, if you are curious
EPP has four levels — `power`, `balance_power`, `balance_performance`, and `performance` — and lives in
a kernel file at `/sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference`.

With the ==linked== toggle off, ROG Control Center shows a per-profile dropdown ("EPP for Balanced
Policy", and so on) so you can pair each Throttle Policy with a specific EPP by hand. With it on, those
pairings are chosen for you. For a beginner, leave it linked.
::::

<!-- TODO image: ROG Control Center — linked-EPP toggle + per-profile EPP dropdowns -->

## **Automate: performance on AC, power-saving on battery**

This is the payoff. Instead of flipping the Throttle Policy by hand every time you plug or unplug, you
tell your laptop to do it for you: full ==Performance== on the charger, quiet and efficient on ==battery==.

In ROG Control Center, find the ==Throttle Policy for power state== section. It has two switches:

:::steps

- **Turn on "Throttle Policy on AC"**

  Set its dropdown to ==Performance== (or Balanced if you prefer a cooler, quieter machine while
  plugged in). This is what runs whenever the charger is connected.

- **Turn on "Throttle Policy on Battery"**

  Set its dropdown to ==Quiet==. This is what runs the moment you unplug.

- **Leave the linked-EPP toggle on**

  With ==Energy Performance Preference linked to Throttle Policy== on (from the last section), the CPU
  tuning follows each profile automatically — no extra step.

:::

That is it. From now on your laptop ramps up on the charger and calms down on battery without you
lifting a finger.

<!-- TODO image: ROG Control Center — "Throttle Policy for power state" AC/battery toggles -->

## **Verify it's working**

Want proof it actually switched? A couple of quick checks:

```bash
asusctl profile -p                          # the profile asusctl thinks is active
cat /sys/firmware/acpi/platform_profile     # the profile the hardware is actually on
```

Both should agree. For the live test, unplug your charger and run the second command again — the profile
should flip to your battery choice. Plug back in and it flips back.

::::details Deeper checks
See which power source you are on (`1` means AC / plugged in):

```bash
cat /sys/class/power_supply/A*/online
```

Watch the service react in real time as you plug and unplug:

```bash
journalctl -u asusd -f
```

::::

## **Power profiles vs. your desktop's toggle**

You may have noticed your desktop already has a ==Power Saver / Balanced / Performance== switch — in
GNOME or KDE Quick Settings, or the Niri power menu. That switch and `asusctl` both change the ==same==
underlying hardware setting, so only one of them should be in charge at a time.

The good news: modern `asusd` speaks the same language as that desktop toggle, so once you have done the
`power-profiles-daemon` step from [the install section](#installing-asusctl), the two work together — your
desktop switch simply routes through `asusctl`. The rule to remember is just ==run one power manager==,
and on Fedora that is `power-profiles-daemon`.

## **Tiling window managers**

GNOME and KDE users get that Quick Settings power toggle for free. If you run a tiling window manager on
==DankMaterialShell== (Quickshell), you can get an equivalent right in your bar.

- [Dank ASUS Control Center](https://github.com/shazzaam7/DankAsusControl) — by Shazzaam

  :::info A DankMaterialShell plugin that surfaces `asusctl` power profiles (and `supergfxctl` GPU
  modes) as controls in the DankBar. Needs `asusctl`, `supergfxctl`, and `upower`.
  :::

  :::tip Install
  It is in the DMS plugin registry, so one command does it:

  ```bash
  dms plugins install dankAsusControlCenter
  ```

  :::

- [ASUS Control](https://github.com/pseudofractal/AsusControl) — an alternative DankMaterialShell plugin
  covering the same ground, if you would rather try that one.

  :::info A separate DMS plugin exposing `asusctl` controls in your bar.
  :::

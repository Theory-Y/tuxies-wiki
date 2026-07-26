---
tags:
  - Intermediate
  - Fixes
  - ASUS
title: ProArt P16 (2025) Fedora
createTime: 2026/07/26 09:40:00
permalink: /guides/proart-p16-2025/
---

:::info What this guide covers
Machine-specific fixes for the ==ASUS ProArt P16 (2025)== (AMD Ryzen AI CPU + NVIDIA RTX dGPU) running Fedora Linux.

For everything that is not specific to this machine — NVIDIA driver install, ==Cardwire== GPU switching, and letting the NVIDIA chip power down during sleep — see the [GPU Guide](/guides/gpu/).
:::

## **Overnight Battery Drain** while asleep

The symptom: close the lid on a full battery, wake up to a ==dead, warm laptop==. On our unit this drained ~7% per hour asleep — a full battery gone in one night.

The cause was not the CPU, and mostly not the dGPU either. The ==touchpad== (`ASCF1A01:00`, an I2C device) fires a constant storm of interrupts — about ==15 per second== — and it is armed as a wakeup source out of the box. During modern standby (`s2idle`), the interrupts woke the machine from its deepest sleep state. Measured over a 6-hour sleep, the hardware only truly slept ==53%== of the time.

The fix: tell the system the touchpad is not allowed to wake the machine. The lid and the power button still wake it; tapping the touchpad no longer does (which most people never relied on anyway).

::::steps

- **Silence the touchpad as a wakeup source**

  Create one udev rule so the setting applies on every boot:

  ```bash
  sudo tee /etc/udev/rules.d/90-touchpad-no-wakeup.rules <<'EOF'
  ACTION=="add", SUBSYSTEM=="i2c", KERNEL=="i2c-ASCF1A01:00", ATTR{power/wakeup}="disabled"
  EOF
  ```

  And apply it immediately without rebooting:

  ```bash
  echo disabled | sudo tee /sys/bus/i2c/devices/i2c-ASCF1A01:00/power/wakeup
  ```

- **Verify**

  Sleep the laptop for at least half an hour, wake it, and check how long the hardware really slept:

  ```bash
  grep . /sys/power/suspend_stats/last_hw_sleep
  # microseconds — divide by 1,000,000 for seconds
  ```

  It should now be ==95% or more== of the time the lid was closed.

::::

:::tip Results on our unit
Before any fixes: ==~6.8% battery per hour== asleep, warm chassis, 53% hardware-sleep residency.

After this fix: ==under 1% per hour== and over 99.8% residency — a full night of sleep now costs under 10% battery.
:::

::::details How the culprit was found (technical detail)

- `journalctl` showed one continuous suspend the whole night, so the machine ==was== asleep — it just was not sleeping deeply.
- `/sys/power/suspend_stats/last_hw_sleep` showed hardware-sleep residency far below the suspend duration (53%).
- Enumerating `/sys/class/wakeup/wakeup*/` by `event_count` pointed at `i2c-ASCF1A01:00` with ==582,000+ events== in half a day of uptime — an interrupt storm, and the device was wakeup-armed.
- The storm itself (15 interrupts/s even while awake) looks like an `i2c-hid` quirk on this board; a future BIOS/firmware update may calm it. Disarming it as a wakeup source is enough to fix sleep either way.
- The generic version of this diagnosis lives in the [GPU Guide](/guides/gpu/#fixing-battery-drain-during-sleep) — measure residency first, then hunt wakeup sources.

::::

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

For everything that is not specific to this machine — NVIDIA driver install, ==Cardwire== GPU switching, and `asusctl` power management, see:

- [GPU Guide](/guides/gpu/)
- [ASUS Laptop Control (asusctl)](/guides/asusctl/)

:::

## **Overnight Battery Drain** while asleep

The symptom: close the lid on a full battery, wake up to a ==dead, warm laptop==. On our unit this drained ~7% per hour asleep — a full battery gone in one night.

The ==touchpad== (`ASCF1A01:00`) fires a constant interrupts (about 15/s). During modern standby (`s2idle`), the interrupts woke the machine from its deepest sleep state. Measured over a 6-hour sleep, the hardware only truly slept ==53%== of the time.

The fix: tell the system the touchpad is not allowed to wake the machine. The lid and the power button still wake it; tapping the touchpad no longer does (which most people never relied on anyway).

::::steps

- **Silence the touchpad as a wakeup source**

  Create one udev rule so the setting applies on every boot:

  ```bash
  sudo tee /etc/udev/rules.d/90-touchpad-no-wakeup.rules <<'EOF'
  ACTION=="add", SUBSYSTEM=="i2c", KERNEL=="i2c-ASCF1A01:00", ATTR{power/wakeup}="disabled"
  EOF
  ```

  And apply it immediately without rebooting (this command only disables touchpad wakeup for one boot):

  ```bash
  echo disabled | sudo tee /sys/bus/i2c/devices/i2c-ASCF1A01:00/power/wakeup
  ```

- **Verify**

  Sleep the laptop for at least half an hour, wake it, and check how long the hardware really slept:

  ```bash
  grep . /sys/power/suspend_stats/last_hw_sleep
  # output is in microseconds — divide by 1,000,000 for seconds
  ```

  It should now be ==95% or more== of the time the lid was closed.

::::

:::tip Results on our unit (AMD AI HX370, NVIDIA 4060, 32 GB)
Before any fixes: ~6.8% battery per hour asleep, warm chassis, 53% hardware-sleep residency.

After this fix: ==under 1% per hour== and over 99.8% residency — ==a full night of sleep now costs under 10% battery==.
:::

::::details How the culprit was found (technical detail)

Credit: Debugged with Claude

- `journalctl` showed one continuous suspend the whole night, so the machine ==was== asleep — it just was not sleeping deeply.
- `/sys/power/suspend_stats/last_hw_sleep` showed hardware-sleep residency far below the suspend duration (53%).
- Enumerating `/sys/class/wakeup/wakeup*/` by `event_count` pointed at `i2c-ASCF1A01:00` with ==582,000+ events== within 8 hours.
- The storm itself (15 interrupts/s even while awake) looks like an `i2c-hid` quirk on this board; a future BIOS/firmware update may calm it. Disarming it as a wakeup source is enough to fix sleep either way.

::::

## **ProArt Button** does nothing

The button next to the power key opens ProArt Creator Hub on Windows. On Linux it is ==silent==: the keyboard sends a code the kernel driver does not turn into a key, so no desktop, keybind tool or `keyd` can see it.

The fix is a small background service that reads the keyboard directly and runs a command of your choice when the button is pressed.

::::steps

- **Allow your user to read the keyboard**

  Only root can read the raw keyboard by default. This udev rule lets the `input` group (which your user is in) read it too:

  ```bash
  sudo tee /etc/udev/rules.d/70-proart-key.rules <<'EOF'
  KERNEL=="hidraw*", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="19b6", GROUP="input", MODE="0640"
  EOF
  sudo udevadm control --reload && sudo udevadm trigger --subsystem-match=hidraw
  ```

- **Create the listener**

  Save this as `~/.local/bin/proart-key`. Change `ACTION` to whatever you want the button to run. The example toggles the [Dank ASUS Control](https://github.com/aier9500/DankAsusControl) popout; `["rog-control-center"]` would open ROG Control Center instead.

  ```python
  #!/usr/bin/env python3
  import glob, os, subprocess

  KBD_HID_ID = "HID_ID=0003:00000B05:000019B6"
  ACTION = ["dms", "ipc", "call", "widget", "toggle", "dankAsusControlCenter"]

  dev = next(
      "/dev/" + p.split("/")[4]
      for p in glob.glob("/sys/class/hidraw/*/device/uevent")
      if KBD_HID_ID in open(p).read()
  )
  fd = os.open(dev, os.O_RDONLY)
  while True:
      if os.read(fd, 64)[:2] == b"\x5a\x8b":
          subprocess.Popen(ACTION, start_new_session=True)
  ```

  ```bash
  chmod +x ~/.local/bin/proart-key
  ```

- **Run it at login**

  ```bash
  mkdir -p ~/.config/systemd/user
  tee ~/.config/systemd/user/proart-key.service <<'EOF'
  [Unit]
  Description=ProArt key listener
  After=graphical-session.target
  PartOf=graphical-session.target

  [Service]
  ExecStart=%h/.local/bin/proart-key
  Restart=always
  RestartSec=3

  [Install]
  WantedBy=graphical-session.target
  EOF
  systemctl --user daemon-reload
  systemctl --user enable --now proart-key.service
  ```

- **Verify**

  Press the button. If nothing happens, check the service:

  ```bash
  systemctl --user status proart-key
  ```

::::

:::tip Other ASUS laptops
The `idProduct` (`19b6`) and `HID_ID` are for the ProArt P16's keyboard. On another model, find yours with `grep HID_ID /sys/class/hidraw/*/device/uevent` (the one whose `HID_NAME` says `ITE`) and swap both values.
:::

::::details How the button was traced (technical detail)

Credit: Debugged with Claude

- `libinput debug-events` and `evtest` showed nothing on press: the button never becomes an input event.
- Reading the keyboard's `hidraw` node as root printed `5a 8b 00` on press and `5a 00 00` on release. `0x5a` is the ASUS vendor report, `0x8b` the button's code.
- The `hid-asus` kernel driver has no mapping for `0x8b`, so it drops the report. Until a kernel adds one, reading `hidraw` directly is the only way to see it.

::::

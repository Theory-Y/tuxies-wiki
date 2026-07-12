---
tags:
  - Beginner
  - Fixes
title: Razer Blade 14 2023 Fedora
createTime: 2026/05/05 17:50:44
permalink: /guides/rb-14-2023-fedora/
---

## **RazerBlade 14 (2023) General Fedora Fix**

## **Speaker**

[See `rb14-2023-audio-fix` for details](https://github.com/yadu-tv/rb14-2023-audio-fix/)

## **WiFi**

==Low Speed WiFi Fix==: Firstly, disable WiFi6 (ax) to prevent WiFi6 issues with Linux.

```bash
sudo nano /usr/local/bin/fix-wifi.sh
```

```bash
#!/bin/bash

modprobe -r ath11k_pci
modprobe ath11k_pci disable_11ax=1
```

:::note `Ctrl O` → `Enter` (Save File) → `Ctrl X` (Exit)
:::

Grant access:

```bash
sudo chmod a+x /usr/local/bin/fix-wifi.sh
```

```bash
sudo nano /etc/systemd/system/fix-wifi.service
```

```ini
[Unit]
Description=Fix ath11k WiFi (disable ax)
After=NetworkManager.service
Wants=NetworkManager.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/fix-wifi.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reexec
sudo systemctl enable fix-wifi.service
reboot
```

Check:

```bash
sudo systemctl status fix-wifi.service
```

Expected to see `Active: active (exited)`

Try speedtest.

The fix is essentially these two lines:

```bash
modprobe -r ath11k_pci
modprobe ath11k_pci disable_11ax=1
```

Try straight up running these two lines if the startup script combo doesn't work.

==If The Issue Persists (presumably occasionally getting low speed WiFi after reboot)==: That most likely leads to a RX aggregation issue. The fix is to try reconnect manually.

Add a script to reconnect only once after connecting to WiFi. Create the dispatcher script:

```bash
sudo nano /etc/NetworkManager/dispatcher.d/99-fix-wifi
```

Paste the following:

```bash
#!/bin/bash

IFACE="$1"
STATUS="$2"

MARKER="/tmp/fix-wifi-done"

if [ "$IFACE" = "wlp3s0" ] && [ "$STATUS" = "up" ]; then

    if [ -f "$MARKER" ]; then
        exit 0
    fi

    touch "$MARKER"

    /usr/bin/systemctl start wifi-reconnect.service
fi
```

Note that you don't want to use `wlp3s0` as well.
Check `iw dev` and find the section below:

```
Interface wlp3s0
        ifindex 3
        wdev 0x100000001
```

Interface code similar to ==`wlp3s0`== is what you want.

This dispatcher script runs a service `wifi-reconnect.service` when connecting to WiFi automatically during startup. You need to create the service as well.

```bash
sudo nano /etc/systemd/system/wifi-reconnect.service
```

```ini
[Unit]
Description=Reconnect WiFi

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -c 'sleep 2 && /usr/bin/nmcli dev disconnect wlp3s0 && sleep 1 && /usr/bin/nmcli dev connect wlp3s0'
```

It waits 2 seconds, disconnects `wlp3s0`, waits 1 second, and then connects `wlp3s0` (Note: Use your own interface code)

Grant access. The script must be owned by root and must not be group- or world-writable, otherwise NetworkManager will ignore it:

```bash
sudo chmod a+x /etc/NetworkManager/dispatcher.d/99-fix-wifi
reboot
```

:::note You probably want both the WiFi6 fix and RX aggregation fix, as the WiFi issue is multi-dimensional.
:::

### **Optional: Performance Mode**

==Enforce Performance Mode To Ensure WiFi Speed==

```bash
sudo iw dev wlp3s0 set power_save off
```

### **Optional:** Timer Based **WiFi6 (ax)** Disable Trigger

If the startup script (disable ax) didn't last long. Try adding a timer based script to disable WiFi6 periodically, preventing potential firmware reset.

Be sure you run `chmod a+x /usr/local/bin/fix-wifi.sh` to grant access permission first.

```bash
sudo nano /etc/systemd/system/fix-wifi.timer
```

```ini
[Unit]
Description=Run fix-wifi periodically

[Timer]
OnBootSec=15
OnUnitActiveSec=30
Unit=fix-wifi.service

[Install]
WantedBy=timers.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now fix-wifi.timer
```

Check `sudo systemctl status fix-wifi.timer`. Expected to see `Active: active (running)`

## **System Freeze**

==Modify GRUB Config To Pretend To Be Windows (RazerBlade motherboard specialises on Windows)==

Append the parameters below to `GRUB_CMDLINE_LINUX="..."`:

```
acpi_osi=! acpi_osi=\"Windows 2020\"
```

Add `processor.max_cstate=5 pcie_aspm=off` as well if you still experience freezes.

Finally, run the following to regenerate config:

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

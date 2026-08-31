---
title: NuPhy Keyboard Configuration on Linux (With nuphy.io)
createTime: 2026/08/31 16:30:00
permalink: /guides/nuphy-keyboard-configuration-with-nuphyio/
tags:
  - Beginner
  - Peripherals
  - Fixes
---

## **Use a Chromium Browser**

nuphy.io talks to the keyboard through a browser feature called WebHID.

Chromium, Google Chrome, Microsoft Edge, and other Chromium browsers support WebHID. Firefox-based browsers do not.

## **Granting the Browser Access to the Keyboard**

WebHID reaches the keyboard through its raw device file, `/dev/hidraw*`. By default, only the system administrator account can read these files, so the browser cannot open them.

A udev rule fixes this. A udev rule is a system file that tells Linux how to treat a device the moment it is plugged in.

::::steps

- **Create the rule file**

  ```bash
  sudo $EDITOR /etc/udev/rules.d/70-nuphy.rules
  ```

  This creates and opens a new file, write the following to it:

  :::code-tabs

  @tab /etc/udev/rules.d/70-nuphy.rules

  ```
  KERNEL=="hidraw*", ATTRS{idVendor}=="19f5", MODE="0660", TAG+="uaccess"
  ```

  :::

  :::details Technical details...
  - `KERNEL=="hidraw*"` applies the rule to raw device files opened by WebHID.
  - `ATTRS{idVendor}=="19f5"` narrows it to devices made by NuPhy. `19f5` is the number assigned to NuPhy for USB devices, so nothing else on your machine is affected.
  - `MODE="0660"` allows browser to both read and write.
  - `TAG+="uaccess"` hands the access to a person logged in to the machine.

  :::

- **Unplug and re-plug your keyboard.**

::::

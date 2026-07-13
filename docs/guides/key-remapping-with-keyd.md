---
title: Key Remapping with keyd
createTime: 2026/05/12 16:12:27
permalink: /guides/key-remapping-with-keyd/
tags:
  - Beginner
  - Peripherals
  - Productivity
  - Fixes
---

::: info What is `keyd?`
`keyd` is a key remapping daemon for Linux that works at the kernel level. `keyd` remaps keys before any application sees them, making it one of the most reliable remapping solutions available on Linux.

This guide walks you through installing keyd from source, writing a basic configuration, and optionally running the setup script to apply a preset configuration and register keyd as an internal keyboard.
:::

:::details Quick append
If you would like to append everything in this guide quickly you can [download the zip](/assets/key-remapping-with-keyd/key-remapping-with-keyd.zip) and run the `keyd-setup.sh` bash script after installing all prerequisites.
:::

## **Prerequisites**

:::warning Before starting, make sure `make` and a C compiler (`cc`) are installed on your system. These are build dependencies required to compile keyd from source.
:::

:::tabs#distro
@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install make gcc
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install make gcc
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S make gcc
```

:::

## **Installing keyd**

`keyd` is not available in most distribution repositories, so it is installed via its GitHub source.

:::: steps

- **Clone and build**

  Create a directory for your installations and clone the repository into it:

  ```bash
  mkdir -p ~/Installations && cd ~/Installations
  git clone https://github.com/rvaiya/keyd
  cd keyd
  ```

  Then compile and install:

  ```bash
  make && sudo make install
  ```

- **Enable the keyd service**

  keyd runs as a `systemd` service. Enable and start it in one command:

  ```bash
  sudo systemctl enable --now keyd
  ```

  The `--now` flag both enables the service on boot and starts it immediately. You can verify it is running with:

  ```bash
  sudo systemctl status keyd
  ```

::::

## **Configuring keyd**

keyd reads its configuration from files placed in `/etc/keyd/`. The main configuration file is `/etc/keyd/default.conf`.

### **Configuration file structure**

A keyd config file has two required sections:

- `[ids]` — Specifies which keyboards the config applies to. Put a `*` to apply to all keyboards.
- `[main]` — Defines your key remappings and layers.

You can also add extra sections for layers — for example, a `[shift]` section changes what keys do while `Shift` is held down.

Here is a minimal example that demonstrates common remaps:

:::tabs

@tab /etc/keyd/default.conf

```conf
# Keyd remaps: Copilot key -> Ctrl; CapsLock -> Backspace,
# Shift + CapsLock -> CapsLock

# Place in /etc/keyd/default.conf

# Edit the file to your liking

[ids]
*

[main]
leftshift+leftmeta+f23 = layer(control)
capslock = backspace

# Shift + capslock for capslock
[shift]
capslock = capslock
```

:::

| Mapping                                   | What it does                                                  |
| ----------------------------------------- | ------------------------------------------------------------- |
| `leftshift+leftmeta+f23 = layer(control)` | Remaps a custom key combo (e.g. Copilot key) to act as Ctrl   |
| `capslock = backspace`                    | Remaps Caps Lock to Backspace                                 |
| `capslock = capslock` (under `[shift]`)   | Hold `Shift` and press Caps Lock to toggle Caps Lock normally |

:::tip
You can find a full list of valid key names in the keyd man page:

```bash
man keyd
```

:::

### **Applying a configuration**

After writing your config, reload keyd to apply it immediately — no reboot needed:

```bash
sudo keyd reload
```

## **Registering keyd as an Internal Keyboard**

:::info ==This step is optional for desktops.== It is primarily useful on laptops where you want palm rejection and other libinput features to work with your remapped keyboard.
:::

Create the directory if it does not exist, then write the quirks file:

```bash
sudo mkdir -p /etc/libinput
sudo nano /etc/libinput/local-overrides.quirks
```

Paste the following content:

:::tabs
@tab /etc/libinput/local-overrides.quirks

```conf
# Libinput Local Quirks
# Save as /etc/libinput/local-overrides.quirks

[Recognise Keyd as Internal Keyboard]

MatchUdevType=keyboard
MatchName=keyd*keyboard
AttrKeyboardIntegration=internal
```

:::

Save and close the file (`Ctrl`+`O`, `Enter`, `Ctrl`+`X` in nano).

### **Verifying the registration**

`libinput` is a library your desktop loads, not a background service — so there is no `reload` command for it. It re-reads its quirks files every time an input device is added, which means a reboot, or simply restarting `keyd`, re-applies them:

```bash
sudo systemctl restart keyd
```

Then test it: open any text field, start typing, and swipe on the touchpad **while** you type.

If the registration worked, the pointer stays put — your desktop now treats keyd's keyboard as internal and disables the touchpad while you type.

If nothing changes, log out and back in, then try the typing test again.

:::warning The quirks file must be world-readable
If the file ends up root-only (mode `600`), it is silently ignored. Set it to mode `644`:

```bash
sudo chmod 644 /etc/libinput/local-overrides.quirks
```

:::

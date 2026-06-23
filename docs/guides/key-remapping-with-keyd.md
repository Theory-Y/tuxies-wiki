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
If you would like to append everything in this guide quickly you can download and run [this](https://github.com/Theory-Y/tuxies-wiki/blob/master/resources/key-remapping-with-keyd/keyd-setup.sh) bash script after installing all prerequisites.
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

`keyd` is not available in most distribution repositories, so it is installed by compiling from its GitHub source.

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

keyd reads its configuration from files placed in `/etc/keyd/`. The main configuration file is `/etc/keyd/default.conf`, and it applies to all keyboards by default.

### **Configuration file structure**

A keyd config file has two required sections:

- `[ids]` — Specifies which keyboards the config applies to. Put a `*` to apply to all keyboards.
- `[main]` — Defines your key remappings and layers.

Here is a minimal example that demonstrates common remaps:

:::tabs

@tab /etc/keyd/default.conf

```conf
# Keyd remap Copilot Key to Right Control and Double Shift to CAP
# place in /etc/keyd/

[ids]
*

[main]
capslock = backspace
leftshift+rightshift = capslock
leftshift+leftmeta+f23 = layer(control)
```

:::

| Mapping                                   | What it does                                                      |
| ----------------------------------------- | ----------------------------------------------------------------- |
| `capslock = backspace`                    | Remaps Caps Lock to Backspace                                     |
| `leftshift+rightshift = capslock`         | Press both Shifts together to toggle Caps Lock                    |
| `leftshift+leftmeta+f23 = layer(control)` | Remaps a custom key combo (e.g. Copilot key) to act as Right Ctrl |

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

To verify the config was written correctly:

```bash
sudo cat /etc/keyd/default.conf
```

## **Registering keyd as an Internal Keyboard**

:::info ==This step is optional for desktops.== It is primarily useful on laptops where you want palm rejection and other libinput heuristics to work with your remapped keyboard.
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

To confirm the quirk actually applied, find the event node for keyd's virtual keyboard, then list the quirks `libinput` matched to it:

:::tip The `libinput` command-line tool ships in a separate package from the base library on every major distro — install it before running the commands below.
:::

:::tabs#distro

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install libinput-utils
```

Only the `quirks` subcommand needs this — `list-devices` is already in the base `libinput` package.

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install libinput-tools
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S libinput-tools
```

:::

```bash
# note the "Kernel: /dev/input/eventXX" line for "keyd virtual keyboard"
sudo libinput list-devices | grep -A1 "keyd virtual keyboard"

# list the quirks for that device (replace eventXX)
sudo libinput quirks list /dev/input/eventXX
```

If the output contains `AttrKeyboardIntegration=internal`, keyd is now treated as an internal keyboard. If `libinput` finds a typo in the file, it prints the error here instead.

:::warning The quirks file must be world-readable
`libinput` parses `/etc/libinput/local-overrides.quirks` from inside your desktop session — as your user, not `root`. If the file ends up root-only (mode `600`), it is silently ignored. Match the stock files in `/usr/share/libinput/` (mode `644`):

```bash
sudo chmod 644 /etc/libinput/local-overrides.quirks
```

:::

:::info There is no on/off toggle for this in your desktop's settings. The only effect is that `libinput` now pairs keyd's keyboard with your touchpad for palm rejection and disable-while-typing — so verify it through the `quirks list` output above, not a settings menu.
:::

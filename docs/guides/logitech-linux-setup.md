---
title: Logitech Linux Setup
createTime: 2025/11/10 11:33:19
permalink: /guides/logitech-linux-setup/
draft: false
tags:
  - Beginner
  - Peripherals
  - Productivity
  - Fixes
contributors:
  - aier
---

:::info This guide covers Logitech devices connecting via Unifying, Bolt, Nano, or Bluetooth receivers. It replicates `Logi Options+` ==key reassignment== and the ==Actions Ring== using `Solaar` and `Kando` respectively.
:::

::::details Quick append

Want both presets applied at once? Download the [`logitech-linux-setup`](https://github.com/Theory-Y/tuxies-wiki/tree/master/resources/logitech-linux-setup) folder — or [download the zip](/assets/logitech-linux-setup/logitech-linux-setup.zip) — and run the installer. It copies the `Solaar` and `Kando` presets into the right config directories (auto-detecting `Flatpak` vs native; use `--flatpak` or `--native` to force), backing up any existing files first.

:::warning Install `Solaar` and `Kando` before running `install.sh`. When neither a Flatpak nor a native install is detected, the configs are applied for the native app's path, but the configs would not take effect until the apps are installed!
:::

```bash
cd logitech-linux-setup
chmod +x install.sh
./install.sh
```

:::tip Quit `Solaar` before running so it loads the new rules on next launch; `Kando` hot-reloads, so its menus apply immediately. Device-specific `Solaar` settings (DPI, backlight, haptic) are per-device — set them in the GUI after pairing.
:::

::::

## **Part 1: Solaar — Key Reassignment**

:::note Follow [this](https://github.com/Theory-Y/tuxies-wiki/tree/master/resources/logitech-linux-setup) link to download the Solaar button-remap preset (`rules.yaml`) for the MX Master 4 and MX Keys S.
`rules.yaml` is the portable part of the Solaar configuration — it defines which button fires which key event and works across machines. Device-specific settings (DPI, backlight, haptic level, smart-shift, scroll ratchet, etc.) are ==not portable==: they are stored per physical device and must be configured in the Solaar GUI after pairing.
:::

The example `rules.yaml` remaps the MX Keys S F-row smart-action keys and several MX Master 4 mouse buttons — expand below for the full list of what the preset includes.

::::details What the preset remaps — all mappings for MX Keys S and MX Master 4

**MX Keys S — F-row smart-action keys**

- **Dictation → `Super`+`i`** — the Dictation key has no native Linux action, so it's repurposed to open GNOME Settings.
- **Emoji → `Super`+`Shift`+`v`** — fires `Super`+`Shift`+`v`, intended for the emoji-copy GNOME extension; the binding stays inert until you install an emoji extension/app bound to that shortcut.
- **Mute Microphone → `XF86_AudioMicMute`** — emits the proper mic-mute keysym so the key actually toggles the microphone under Linux (the stock key sends no recognised mic-mute event).
- **Screen Capture → `Print`** — sends `Print` (PrtSc) to trigger GNOME's screenshot tool, since the stock Logitech "snip" action isn't wired on Linux.
- **Screen Lock → `Tab`** — the lock key sits next to the numpad; remapping it to `Tab` gives a numpad-adjacent `Tab` for faster numeric/spreadsheet data entry (field-to-field) without reaching across the keyboard.

**MX Master 4 — mouse buttons**

- **Back Button → holds `Ctrl`** — pressing the button depresses `Control_L`; releasing it lifts `Control_L`. The physical button acts as a held `Ctrl` modifier for the duration of the press.
- **Forward Button → holds `Shift`** — pressing depresses `Shift_L`; releasing lifts it. Lets you hold `Shift` with your thumb to extend selections or trigger `Shift`-modified shortcuts.
- **Mouse Gesture Button → holds `Super`** — pressing depresses `Super_L`; releasing lifts it. Holding the gesture button while moving the mouse triggers any `Super`-based shortcuts or gestures active in your desktop environment.
- **Haptic button → `Super`+`Shift`+`F1`** — a single click fires `Super_L`+`Shift_L`+`F1`, which is the trigger shortcut that opens the **Kando** menu (matching the Kando menu binding set in Part 2 of this guide).

::::

### **Installing Solaar**

::::tabs

@tab ::simple-icons:flatpak:: Flatpak

```bash
flatpak install flathub io.github.pwr_solaar.solaar
```

:::important The Flatpak version of `Solaar` may not detect devices out of the box due to `udev` permission restrictions. If your device is not detected, follow the [udev rules setup](https://pwr-solaar.github.io/Solaar/installation) from the Solaar documentation, or use `Flatseal` to grant USB device access.
:::

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install solaar
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S solaar
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install solaar
```

::::

:::tip If your device is not detected after install, log out and back in, then replug the receiver.
:::

### **Pairing & managing your device**

:::steps

- **Pair a new device**

  Click your receiver in the left panel and select ==Pair new device==, then follow the on-screen prompt. Bluetooth devices appear automatically if system Bluetooth is active.

  ![Solaar Pair New Device](/assets/logitech-linux-setup/solaar-pair-new-device.png)

- **Adjust device settings**

  Select your device in the left panel. The right panel exposes all available settings — ==DPI==, scroll direction, pointer speed, and function-key behaviour — depending on your hardware model. These settings are stored per physical device and are ==not exported== with `rules.yaml`; set them once in the GUI after pairing.

:::

### **Remapping buttons with rules**

The ==Rules Editor== is Solaar's equivalent of `Logi Options+` key redirection. Rules intercept a button press and fire a custom action — a keystroke, shell command, or modifier combination — with optional conditions based on the active application.

:::steps

- **Open the Rules Editor**

  ![Solaar Rules Editor](/assets/logitech-linux-setup/solaar-rules-editor.png)

- **Create a new rule**

  Right-click the ==Rule== node and select ==Add rule==. A new empty rule appears in the tree.

- **Add a condition**

  Right-click the new rule and select ==Add condition → Key==. Choose the mouse button to intercept — for example, `Haptic` for the haptic button on the MX Masters 4.

- **Add an action**

  Right-click the same rule and select ==Add action → Key press==. Enter the key combination to send — for example, `Super_L` + `Shift_L` + `F1` as a dedicated trigger shortcut (which can be used to trigger the Kando Menu to work as Action Ring).

- **Save and test**

  Click ==Save==. Press the button — the remapped key event fires immediately with no restart needed.

:::

### **Fixing button remaps on Wayland** (uinput permissions)

If device settings such as battery level, DPI, and renaming work in Solaar but remapped buttons fire no keystroke, the session is missing write access to `/dev/uinput`.

:::warning This fix is only needed on Wayland. X11 sessions use XTEST for synthetic input and are unaffected.
:::

::::details Why this happens (technical detail)

On Wayland, Solaar injects synthetic keypresses through `/dev/uinput`. The shipped `solaar-udev` rule (`/usr/lib/udev/rules.d/42-logitech-unify-permissions.rules`) tags `uinput` with `uaccess`, but `uaccess` does not work for `uinput` because `uinput` is a `static_node` created at boot — it is not bound to a login seat, so the per-session ACL is never applied. On `X11`, Solaar uses `XTEST` for synthetic input and needs no `uinput` access at all.

::::

::::steps

- **Create a udev override rule**

  Create the file `/etc/udev/rules.d/60-uinput.rules` with the following content. The `60-` prefix ensures this file loads after the shipped `42-` rule and takes precedence.

  :::code-tabs

  @tab /etc/udev/rules.d/60-uinput.rules

  ```
  KERNEL=="uinput", GROUP="input", MODE="0660"
  ```

  :::

- **Add your user to the `input` group**

  ```bash
  sudo usermod -aG input $USER
  ```

- **Reload udev and re-login**

  ```bash
  sudo udevadm control --reload-rules && sudo udevadm trigger
  ```

  :::warning A full log-out and log back in is required for the group change to take effect; reloading udev alone is not enough.
  :::

- **After re-login, press a remapped button in a Wayland session** — the assigned keystroke should now fire.

::::

<!-- :::tip Not ready to commit? Run `sudo setfacl -m u:$USER:rw /dev/uinput` for one-shot access that lasts until the next reboot. This lets you confirm the fix works before adding the persistent rule. `setfacl` ships in the `acl` package, which is installed by default on Fedora; on Debian-based systems run `sudo apt install acl` first.
::: -->

## **Part 2: Kando**

:::note Follow [this](https://github.com/Theory-Y/tuxies-wiki/tree/master/resources/logitech-linux-setup/kando) link to download configuration files in the section below.
:::

### **Installing Kando**

:::tabs

@tab ::simple-icons:flatpak:: Flatpak

```bash
flatpak install flathub menu.kando.Kando
```

@tab ::devicon:archlinux:: Arch (AUR)

```bash
yay -S kando-bin
```

@tab ::devicon:debian:: Debian/Ubuntu

Download the `.deb` package from the [Kando releases page](https://github.com/kando-menu/kando/releases) and install it.

```bash
sudo dpkg -i kando-*.deb
```

:::

:::tip `Kando` runs as a background process and must be started at login to be available. Add it to your desktop environment's autostart (on Gnome, you can do this in `Tweaks`).
:::

:::important You must download the [Kando Integration](https://extensions.gnome.org/extension/7068/kando-integration/) extension in order to use Kando in Gnome.
:::

### **Creating your first menu**

:::steps

- **Add a new menu**

  Click ==Add Menu== in the left sidebar. Give it a descriptive name — e.g., 'Productivity' — and confirm.

  ![Kando Add New Menu](/assets/logitech-linux-setup/kando-add-new-menu.png)

- **Add items to the ring**

  Click the ==+== button in the ring diagram to add actions. Drag items around the ring to arrange them in positions that feel natural for your hand.

- **Save and trigger**

  Click ==Save==. Use your assigned trigger shortcut (set in the next section) to open the menu and verify your items appear correctly.

:::

### **Gesture navigation**

`Kando` supports ==marking menus== — a gesture technique where you draw a direction with your cursor to select an item without stopping to click. Once muscle memory is established for a layout, you can open and trigger an action in a single continuous movement, faster than a keyboard shortcut.

:::demo-wrapper
<video src="/assets/logitech-linux-setup/kando-marking-mode.mp4" autoplay loop muted playsinline onloadedmetadata="this.playbackRate=1.25"></video>
:::

### **Binding menus to shortcuts**

Each menu in `Kando` has an independent ==trigger==: a global keyboard shortcut, a mouse button combination, or a shortcut scoped to a single application.

:::steps

- **Open trigger settings**

  In the `Kando` editor, click the menu you want to configure and select the ==Trigger== tab on the right panel.

- **Set a global shortcut**

  Click the shortcut input field and press your desired key combination. A key combo fired by a `Solaar` rule — such as `Super` + `Shift` + `F1` — works perfectly as a hardware trigger here.

:::

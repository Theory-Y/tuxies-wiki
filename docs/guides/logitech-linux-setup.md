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

## **Part 1: Solaar — Key Reassignment**

:::note Follow [this](https://github.com/Theory-Y/tuxies-wiki/tree/master/resources/logitech-linux-setup) link to download an example configuration for the MX Masters 4 and MX Keys S.
The configuration files are ready to use if you have the hardware mentioned above. Otherwise, you may have to do some tweaking in the Solaar app.
:::

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

  Select your device in the left panel. The right panel exposes all available settings — ==DPI==, scroll direction, pointer speed, and function-key behaviour — depending on your hardware model.

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

---
title: Gnome Further Customisation
createTime: 2025/09/26 18:26:21
permalink: /guides/gnome-further-customisation/
tags:
  - Beginner
  - Gnome
  - Productivity
  - Ricing
sticky: 5
contributors:
  - aier
---

:::tip You might want to go through with setting up Gnome through [Gnome Guide](/linux-guides/gnome/) first.
:::

## Better-Looking Fonts

:::tip The Adwaita series font is pretty good, but I find the IBM Plex series to be more modern and pleasing.
:::

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install ibm-plex-fonts-all
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S ttf-ibm-plex
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install fonts-ibm-plex
```

:::

:::tabs

@tab To apply

```bash
gsettings set org.gnome.desktop.interface font-name "IBM Plex Sans 11"
gsettings set org.gnome.desktop.interface document-font-name "IBM Plex Sans 12"
gsettings set org.gnome.desktop.interface monospace-font-name "IBM Plex Mono 11"
```

@tab To reset

```bash
gsettings reset org.gnome.desktop.interface font-name
gsettings reset org.gnome.desktop.interface document-font-name
gsettings reset org.gnome.desktop.interface monospace-font-name
```

:::

## GNOME Extensions

### Universal benefits

:::tip
==🌟== indicates currently used by the editor ==aier==.
:::

:::details Tech details: Why do extension settings use `dconf write`?
Extensions installed from extensions.gnome.org keep their settings schemas inside their own folder, where the `gsettings` command cannot find them (you would get a `No such schema` error). `dconf write` needs no schema, so extension settings use it — system settings elsewhere in this wiki use `gsettings`.
:::

::::::card
::::: collapse

- 🌟 [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)

  :::info Adds AppIndicator, KStatusNotifierItem and legacy Tray icons support to the Shell.
  :::

  ![AppIndicator](/assets/gnome-further-customisation/appindicator.png)

- 🌟 [Lilypad](https://extensions.gnome.org/extension/7266/lilypad/) _(pairs well with AppIndicator)_

  :::info Tidies the tray icons in your top bar — hide the ones you rarely touch.
  :::

- [Auto Power Profile](https://extensions.gnome.org/extension/6583/auto-power-profile/)

  :::info Automatically switches between power profiles (Performance / Balanced / Power Saver) based on whether you're on AC or battery, and on the current battery charge level.
  :::

- [Battery Health Charging](https://extensions.gnome.org/extension/5724/battery-health-charging/)

  :::info Set a battery charging threshold / limit / mode to maximise laptop battery lifespan. Many laptop brands work out of the box; some need extra kernel modules (see the extension's compatibility list).
  :::

  ![Battery Health Charging Demonstration](/assets/gnome-further-customisation/battery-health-limit-demonstration.png)

- 🌟 [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)

  :::info Adds customisable blur effects to GNOME Shell elements for a polished look.
  :::

  ![Blur My Shell Demonstration](/assets/gnome-further-customisation/blur-my-shell-demonstration.png)

- 🌟 [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)

  :::info Prevents screen dimming and suspension on demand.
  :::

  ![Caffeine Demonstration](/assets/gnome-further-customisation/caffeine-demonstration.png)

- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)

  :::info Provides a clipboard history and quick paste menu in the top panel.
  :::

  :::tip Windows-like `<Super>v` keyboard shortcut

  ```bash
  gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>M']"
  dconf write /org/gnome/shell/extensions/clipboard-indicator/toggle-menu "['<Super>V']"
  ```

  :::

  ![Clipboard Indicator Demonstration](/assets/gnome-further-customisation/clipboard-indicator-demonstration.png)

- 🌟 [Copyous](https://extensions.gnome.org/extension/8834/copyous/) _(elegant alternative to Clipboard Indicator)_

  :::info A modern clipboard manager with support for text, code, images, files, links, characters, and colours.
  :::

  ::::tip Install dependencies (needed for the SQLite clipboard-history backend)

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install libgda libgda-sqlite
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install gir1.2-gda-5.0 gir1.2-gsound-1.0
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  sudo pacman -S libgda6
  ```

  :::

  ::::

  :::tip Windows-like `<Super>v` keyboard shortcut

  ```bash
  gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>M']"
  dconf write /org/gnome/shell/extensions/copyous/open-clipboard-dialog-shortcut "['<Super>V']"
  dconf write /org/gnome/shell/extensions/copyous/database-backend "'sqlite'"
  dconf write /org/gnome/shell/extensions/copyous/clipboard-position-vertical "'bottom'"
  ```

  :::

  ![Copyous Demo](/assets/gnome-further-customisation/copyous-demo.png)

- 🌟 [GNOME Fuzzy App Search](https://extensions.gnome.org/extension/3956/gnome-fuzzy-app-search/)

  :::info Enables fuzzy matching in Activities search to find apps without exact names.
  :::

  ![Gnome Fuzzy App Search Demonstration](/assets/gnome-further-customisation/gnome-fuzzy-app-search-demonstration.png)

- 🌟 [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/)

  :::info Tweaks or hides nearly every GNOME Shell UI element for fine‑grained control.
  :::

  :::tip My settings

  ```bash
  # Hide searchbar in overview (you can still search
  # by just typing)
  dconf write /org/gnome/shell/extensions/just-perfection/search false

  # Hide window titles when hovering over windows in
  # overview
  dconf write /org/gnome/shell/extensions/just-perfection/window-preview-caption false

  # Always show workspace switchers no matter how many
  # workspaces are opened (especially useful for dynamic
  # workspace users)
  dconf write /org/gnome/shell/extensions/just-perfection/workspace-switcher-should-show true

  # Make workspace switchers larger
  dconf write /org/gnome/shell/extensions/just-perfection/workspace-switcher-size 13
  ```

  :::

  ![Just Perfection Demonstration](/assets/gnome-further-customisation/just-perfection-demonstration.png)

- [Shotzy](https://extensions.gnome.org/extension/9707/shotzy/)

  :::info Image search on Google Lens, OCR and QR scan directly from the built-in GNOME Screenshot tool.
  :::

- [Night Theme Switcher](https://extensions.gnome.org/extension/2236/night-theme-switcher/)

  :::info Switcher between light and dark theme depending on sunrise/sunset.
  :::

  :::tip Make the light mode shell light.

  ```bash
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/enabled true
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/sunrise "'gsettings set org.gnome.desktop.interface color-scheme prefer-light'"
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/sunset "'gsettings set org.gnome.desktop.interface color-scheme prefer-dark'"
  ```

  :::

:::::
::::::

### Others

::::::card
::::: collapse

- [Kando Integration](https://extensions.gnome.org/extension/7068/kando-integration/)

  :::info Allows you to use the Kando Menu in Gnome Wayland sessions.
  :::

  :::note [Download the zip](/assets/logitech-linux-setup/logitech-linux-setup.zip) for the configuration files to achieve the effect in the video below.
  :::

  :::demo-wrapper
  <video src="/assets/gnome-further-customisation/kando-marking-mode.mp4" autoplay loop muted playsinline onloadedmetadata="this.playbackRate=1.25"></video>
  :::

- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)

  :::info Moves the dash out of overview into a dock for quicker app launching and window switching.
  :::

  :::tip My settings
  Go to the extension's settings --> Appearances, turn on `Shrink the dash` to make the dash smaller and slicker.
  :::

  :::tip Fix the keyboard shortcut
  Dash to Dock pops up the dock with `Super`+`Q` by default, which clashes with Close window shortcut from [Gnome Guide](/linux-guides/gnome). Move it to `Super`+`W`:

  ```bash
  dconf write /org/gnome/shell/extensions/dash-to-dock/shortcut "['<Super>w']"
  ```

  :::

  ![Dash to Dock Demonstration](/assets/gnome-further-customisation/dash-to-dock-demonstration.png)

- 🌟 [Stage Manager](https://extensions.gnome.org/extension/9528/stage-manager/) _(alternative to Dash to Dock)_

  :::info macOS-style window management: groups your open windows into "stages" and stacks the rest as thumbnail cards down the left edge, so only one group is on screen at a time.
  :::

  :::tip Hide the dash to make room
  Stage Manager lives down the left edge, so the app dash just gets in the way. Hide it with the `Just Perfection` extension (listed above):

  ```bash
  dconf write /org/gnome/shell/extensions/just-perfection/dash false
  ```

  :::

- [Tiling Shell](https://extensions.gnome.org/extension/7065/tiling-shell/)

  :::info Brings tiling window management to GNOME, allowing automatic window arrangements in customisable layouts.
  :::

- [Focus changer](https://extensions.gnome.org/extension/4627/focus-changer/)

  :::info Switches focus to the window sitting left, right, above, or below the current one with customisable keyboard shortcuts.
  :::

- 🌟 [Alphabetical App Grid](https://extensions.gnome.org/extension/4269/alphabetical-app-grid/)

  :::info Sorts the app grid alphabetically to make apps easier to find.
  :::

  :::tip My settings
  ==Position of ordered folders --> Start==, to make folders appear before apps.
  :::

  ![Alphabetical App Grid Demonstration](/assets/gnome-further-customisation/alphabetical-app-grid-demonstration.png)

- [GTK4 Desktop Icon NG](https://extensions.gnome.org/extension/5263/gtk4-desktop-icons-ng-ding/)

  :::info Allows for links, folders, and files in the desktop.
  :::

  ![DING4 Demo](/assets/gnome-further-customisation/ding4-demo.png)

- [App Icons Taskbar](https://extensions.gnome.org/extension/4944/app-icons-taskbar/)

  :::info Windows-styled taskbar
  :::

  :::tip My settings

  ```bash
  # Stylise panel into Windows-styled task bar
  dconf write /org/gnome/shell/extensions/aztaskbar/clock-font-size "(true, 12)"
  dconf write /org/gnome/shell/extensions/aztaskbar/clock-position-in-panel "'RIGHT'"
  dconf write /org/gnome/shell/extensions/aztaskbar/icon-size "24"
  dconf write /org/gnome/shell/extensions/aztaskbar/indicator-color-use-system-accent-color "true"
  dconf write /org/gnome/shell/extensions/aztaskbar/indicator-location "'BOTTOM'"
  dconf write /org/gnome/shell/extensions/aztaskbar/intellihide-key-toggle "['']" # ['<Super>i'], conflicts with Settings app shortcut key
  dconf write /org/gnome/shell/extensions/aztaskbar/isolate-workspaces "false"
  dconf write /org/gnome/shell/extensions/aztaskbar/main-panel-height "(true, 40)"
  dconf write /org/gnome/shell/extensions/aztaskbar/override-panel-clock-format "(true, '%a %R\\n%F')"
  dconf write /org/gnome/shell/extensions/aztaskbar/panel-location "'BOTTOM'"
  dconf write /org/gnome/shell/extensions/aztaskbar/show-apps-button "(true, 0)"

  # Requires Just Perfection extension; moves notifications to bottom right to match with task bar
  dconf write /org/gnome/shell/extensions/just-perfection/notification-banner-position "5"
  ```

  :::

- [Show Desktop Plus](https://extensions.gnome.org/extension/9756/show-desktop-plus/) _(QoL additions to GTK4 Desktop Icons NG)_

  :::info A button that shows your desktop, hiding all other windows. (Just like clicking the bottom right corner or `Super` + `D` in Windows)
  :::

  :::tip My settings

  ```bash
  dconf write /org/gnome/shell/extensions/show-desktop-plus/button-position "'right-end'"
  dconf write /org/gnome/shell/extensions/show-desktop-plus/enable-hotkey true # Super + D to show desktop
  ```

  :::

  :::demo-wrapper
  <video src="/assets/gnome-further-customisation/show-desktop-plus-demo.mp4" autoplay loop muted playsinline onloadedmetadata="this.playbackRate=1.25"></video>
  :::

:::::
::::::

:::info More resources...

This guide is just one stop on my full setup. Here's the full checklist:

**First steps**

- [Gnome Guide](/linux-guides/gnome/)
- Further Gnome Customisation _(you're reading it)_
- [Keyd](/guides/key-remapping-with-keyd/)
- [Logitech Linux Setup](/guides/logitech-linux-setup/)
- [Editor's choice](/linux-apps/editors-choice/)
- [Essentials](/linux-apps/essentials/)

**Dev stuff**

- [Bash customisation](/guides/terminal-customisation-bash/)
- [ghostty-terminal](/guides/ghostty-terminal/)
- [yazi](/guides/yazi/)

**[External resources](/guides/external-resources)**

- Howdy Facial Recognition
- Touchpad Scrolling Sensitivity Fix

:::

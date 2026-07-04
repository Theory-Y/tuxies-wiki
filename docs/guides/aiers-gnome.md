---
title: aier's Gnome (In-Depth Customisations)
createTime: 2025/09/26 18:26:21
permalink: /guides/aiers-gnome/
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
dconf write /org/gnome/desktop/interface/font-name "'IBM Plex Sans 11'"
dconf write /org/gnome/desktop/interface/document-font-name "'IBM Plex Sans 12'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'IBM Plex Mono 11'"
```

@tab To reset

```bash
dconf reset /org/gnome/desktop/interface/font-name
dconf reset /org/gnome/desktop/interface/document-font-name
dconf reset /org/gnome/desktop/interface/monospace-font-name
```

:::

## GNOME Extensions

### Universal benefits

:::tip
==🌟== indicates currently used by the editor ==aier==.
:::

::::::card
::::: collapse

- 🌟 [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)

  :::info Adds AppIndicator, KStatusNotifierItem and legacy Tray icons support to the Shell.
  :::

  ![AppIndicator](/assets/aiers-gnome/appindicator.png)

- 🌟 [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)

  :::info Adds customisable blur effects to GNOME Shell elements for a polished look.
  :::

  ![Blur My Shell Demonstration](/assets/aiers-gnome/blur-my-shell-demonstration.png)

- 🌟 [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)

  :::info Prevents screen dimming and suspension on demand.
  :::

  ![Caffeine Demonstration](/assets/aiers-gnome/caffeine-demonstration.png)

- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)

  :::info Provides a clipboard history and quick paste menu in the top panel.
  :::

  :::tip Windows-like `<Super>v` keyboard shortcut

  ```bash
  dconf write /org/gnome/shell/keybindings/toggle-message-tray "['<Super>M']"
  dconf write /org/gnome/shell/extensions/clipboard-indicator/toggle-menu "['<Super>V']"
  ```

  :::

  ![Clipboard Indicator Demonstration](/assets/aiers-gnome/clipboard-indicator-demonstration.png)

- 🌟 [Copyous](https://extensions.gnome.org/extension/8834/copyous/) _(elegant alternative to Clipboard Indicator)_

  :::info A modern clipboard manager with support for text, code, images, files, links, characters, and colours.
  :::

  :::tip Windows-like `<Super>v` keyboard shortcut

  ```bash
  dconf write /org/gnome/shell/keybindings/toggle-message-tray "['<Super>M']"
  dconf write /org/gnome/shell/extensions/copyous/open-clipboard-dialog-shortcut "['<Super>V']"
  dconf write /org/gnome/shell/extensions/copyous/clipboard-history "'keep-all'"
  dconf write /org/gnome/shell/extensions/copyous/clipboard-position-vertical "'bottom'"
  ```

  :::

  ![Copyous Demo](/assets/aiers-gnome/copyous-demo.png)

- 🌟 [GNOME Fuzzy App Search](https://extensions.gnome.org/extension/3956/gnome-fuzzy-app-search/)

  :::info Enables fuzzy matching in Activities search to find apps without exact names.
  :::

  ![Gnome Fuzzy App Search Demonstration](/assets/aiers-gnome/gnome-fuzzy-app-search-demonstration.png)

- 🌟 [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/)

  :::info Tweaks or hides nearly every GNOME Shell UI element for fine‑grained control.
  :::

  :::tip My settings

  ```bash
  # Hide ripple box in hot corner
  dconf write /org/gnome/shell/extensions/just-perfection/ripple-box false

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

  ![Just Perfection Demonstration](/assets/aiers-gnome/just-perfection-demonstration.png)

- 🌟 [Shotzy](https://extensions.gnome.org/extension/9707/shotzy/)

  :::info Image search on Google Lens, OCR and QR scan directly from the built-in GNOME Screenshot tool.
  :::

- 🌟 [Night Theme Switcher](https://extensions.gnome.org/extension/2236/night-theme-switcher/)

  :::info Switcher between light and dark theme depending on sunrise/sunset.
  :::

  :::tip Make the light mode shell light.

  ```bash
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/enabled 'true'
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/sunrise "\"dconf write /org/gnome/desktop/interface/color-scheme \\\"'prefer-light'\\\"\""
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/sunset "\"dconf write /org/gnome/desktop/interface/color-scheme \\\"'prefer-dark'\\\"\""
  ```

  :::

:::::
::::::

### Others

::::::card
::::: collapse

- 🌟 [Kando Integration](https://extensions.gnome.org/extension/7068/kando-integration/)

  :::info Allows you to use the Kando Menu in Gnome Wayland sessions.
  :::

  :::note Follow [this](https://github.com/Theory-Y/tuxies-wiki/tree/master/resources/logitech-linux-setup/kando) link to download configuration files to achieve the effect in the video below.
  :::

  :::demo-wrapper
  <video src="/assets/aiers-gnome/kando-marking-mode.mp4" autoplay loop muted playsinline onloadedmetadata="this.playbackRate=1.25"></video>
  :::

- 🌟 [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)

  :::info Moves the dash out of overview into a dock for quicker app launching and window switching.
  :::

  :::tip My settings
  Go to the extension's settings --> Appearances, turn on `Shrink the dash` to make the dash smaller and slicker.
  :::

  ![Dash to Dock Demonstration](/assets/aiers-gnome/dash-to-dock-demonstration.png)

- [Tiling Shell](https://extensions.gnome.org/extension/7065/tiling-shell/)

  :::info Brings tiling window management to GNOME, allowing automatic window arrangements in customisable layouts.
  :::

- 🌟 [Focus changer](https://extensions.gnome.org/extension/4627/focus-changer/)

  :::info Switches focus to the window sitting left, right, above, or below the current one with customisable keyboard shortcuts.
  :::

- 🌟 [Alphabetical App Grid](https://extensions.gnome.org/extension/4269/alphabetical-app-grid/)

  :::info Sorts the app grid alphabetically to make apps easier to find.
  :::

  :::tip My settings
  ==Position of ordered folders --> Start==, to make folders appear before apps.
  :::

  ![Alphabetical App Grid Demonstration](/assets/aiers-gnome/alphabetical-app-grid-demonstration.png)

- [GTK4 Desktop Icon NG](https://extensions.gnome.org/extension/5263/gtk4-desktop-icons-ng-ding/)

  :::info Allows for links, folders, and files in the desktop.
  :::

  ![DING4 Demo](/assets/aiers-gnome/ding4-demo.png)

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
  <video src="/assets/aiers-gnome/show-desktop-plus-demo.mp4" autoplay loop muted playsinline onloadedmetadata="this.playbackRate=1.25"></video>
  :::

:::::
::::::

:::info More resources...

This guide is just one stop on my full setup. Here's the full checklist:

**First steps**

- [Gnome Guide](/linux-guides/gnome/)
- aier's Gnome _(you're reading it)_
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

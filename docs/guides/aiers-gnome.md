---
title: aier's Gnome (In-Depth Tips and Tricks)
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

:::important This guide is not going to be as detailed as the ones released in the main series as its content updates much more often as newer versions of Gnome and new extensions come out.
:::

## Facial Recognition With Howdy

:::tip This applies outside of Gnome as well. If your computer supports facial recognition, you can check the details to setting up Howdy from the [official GitHub page](https://github.com/boltgolt/howdy?tab=readme-ov-file). For Fedora 43-44 users, check [Getting Howdy to Run on Fedora](https://mtillmann.blog/posts/howdy-on-fedora-43.html) by Martin's Blog.
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

```bash
dconf write /org/gnome/desktop/interface/font-name "'IBM Plex Sans 11'"
dconf write /org/gnome/desktop/interface/document-font-name "'IBM Plex Sans 12'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'IBM Plex Mono 11'"
```

<!-- dconf reset /org/gnome/desktop/interface/font-name  -->
<!-- dconf reset /org/gnome/desktop/interface/document-font-name  -->
<!-- dconf reset /org/gnome/desktop/interface/monospace-font-name  -->

## GNOME Extensions (Universal Benefits)

::::::card
::::: collapse

- [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)

  ::::card

  :::info Adds AppIndicator, KStatusNotifierItem and legacy Tray icons support to the Shell.
  :::

  ![AppIndicator](/assets/aiers-gnome/appindicator.png)

  ::::

<!-- - [Battery Health Charging](https://extensions.gnome.org/extension/5724/battery-health-charging/)

  ::: info Lets you set charging thresholds to preserve battery health.
  ![Battery Health Limit Demonstration](/assets/aiers-gnome/battery-health-limit-demonstration.png)
  ::: -->

- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)

  ::: info Adds customisable blur effects to GNOME Shell elements for a polished look.
  ![Blur My Shell Demonstration](/assets/aiers-gnome/blur-my-shell-demonstration.png)
  :::

- [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)

  ::: info Prevents screen dimming and suspension on demand.
  ![Caffeine Demonstration](/assets/aiers-gnome/caffeine-demonstration.png)
  :::

- [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)

  ::: info Provides a clipboard history and quick paste menu in the top panel.
  ![Clipboard Indicator Demonstration](/assets/aiers-gnome/clipboard-indicator-demonstration.png)
  :::

  ::: tip Windows-like `<Super>v` keyboard shortcut

  ```bash
  dconf write /org/gnome/shell/keybindings/toggle-message-tray "['<Super>M']"
  dconf write /org/gnome/shell/extensions/clipboard-indicator/toggle-menu "['<Super>V']"
  ```

  :::

- [Copyous](https://extensions.gnome.org/extension/8834/copyous/) _(elegant alternative to Clipboard Indicator)_

  ::: info A modern clipboard manager with support for text, code, images, files, links, characters, and colours.
  ![Copyous Demo](/assets/aiers-gnome/copyous-demo.png)
  :::

  ::: tip Windows-like `<Super>v` keyboard shortcut

  ```bash
  dconf write /org/gnome/shell/keybindings/toggle-message-tray "['<Super>M']"
  dconf write /org/gnome/shell/extensions/copyous/open-clipboard-dialog-shortcut "['<Super>V']"
  dconf write /org/gnome/shell/extensions/copyous/clipboard-history "'keep-all'"
  dconf write /org/gnome/shell/extensions/copyous/clipboard-position-vertical "'bottom'"
  ```

  :::

<!-- - [Emoji Copy](https://extensions.gnome.org/extension/6242/emoji-copy/)

  ::: info Adds an emoji picker to search and copy emojis quickly.
  ![Emoji Copy Demonstration](/assets/aiers-gnome/emoji-copy-demonstration.png)
  :::

  :::tip The default `<Super>.` keybinding for Emoji Copy sometimes interferes with the ibus emoji shortcut, I simply remapped it to `<Super><Shift>v`.
  ::: -->

- [GNOME Fuzzy App Search](https://extensions.gnome.org/extension/3956/gnome-fuzzy-app-search/)

  ::: info Enables fuzzy matching in Activities search to find apps without exact names.
  ![Gnome Fuzzy App Search Demonstration](/assets/aiers-gnome/gnome-fuzzy-app-search-demonstration.png)
  :::

- [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/)

  ::: info Tweaks or hides nearly every GNOME Shell UI element for fine‑grained control.
  ![Just Perfection Demonstration](/assets/aiers-gnome/blur-my-shell-demonstration.png)
  :::

  :::tip My settings:

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

- [Shotzy](https://extensions.gnome.org/extension/9707/shotzy/)

  :::info Image search on Google Lens, OCR and QR scan directly from the built-in GNOME Screenshot tool.
  :::

- [Night Theme Switcher](https://extensions.gnome.org/extension/2236/night-theme-switcher/)

  ::: info Switcher between light and dark theme depending on sunrise/sunset.
  :::

  :::tip Make the light mode shell light.

  ```bash
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/enabled 'true'
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/sunrise "\"dconf write /org/gnome/desktop/interface/color-scheme \\\"'prefer-light'\\\"\""
  dconf write /org/gnome/shell/extensions/nightthemeswitcher/commands/sunset "\"dconf write /org/gnome/desktop/interface/color-scheme \\\"'prefer-dark'\\\"\""
  ```

  :::

- [Tiling Shell](https://extensions.gnome.org/extension/7065/tiling-shell/)

  :::info Brings tiling window management to GNOME, allowing automatic window arrangements in customisable layouts.
  :::

<!-- - [Kiwi is not Apple](https://extensions.gnome.org/extension/8276/kiwi-is-not-apple/)

  ::: info Offers many UI changes to make Gnome more Mac-like. I use it for the window title, lock key indicator, and transparent window move function.
  :::

  ```bash
  # aier's Kiwi settings

  # Disable (for consistency):
  # This feature stylises titlebuttons to look
  # like traffic lights. They can be inconsistent.
  dconf write /org/gnome/shell/extensions/kiwi/enable-app-window-buttons "false"
  dconf write /org/gnome/shell/extensions/kiwi/show-window-controls "false"

  # Enable (for aesthetics):
  # Stylise the keyboard layout indicator
  dconf write /org/gnome/shell/extensions/kiwi/keyboard-indicator "true"

  # Enable (for utility):
  # Great utility; allows you to see lock keys
  # status on the top bar. This replaces the lock
  # keys extension that used to be in my setup.
  dconf write /org/gnome/shell/extensions/kiwi/lock-icon "true"

  # Disable (for personal preference):
  # This feature moves the clock to the right and
  # moves notifications to the quick settings.
  # I prefer the original Gnome layout.
  dconf write /org/gnome/shell/extensions/kiwi/move-calendar-right "false"

  # Disable (due to buginess & personal preference)
  # I personally dislike this behavior as I
  # prefer manual window and workspace management.
  dconf write /org/gnome/shell/extensions/kiwi/move-window-to-new-workspace "false"

  # Enable (for aesthetic & utility)
  # This fills up empty space on the left side and
  # you can click on it for additional functionality.
  dconf write /org/gnome/shell/extensions/kiwi/show-window-title "true"

  # Disable (due to buginess & personal preference)
  dconf write /org/gnome/shell/extensions/kiwi/transparent-move "false"

  # Disable and use blur from Blur My Shell
  dconf write /org/gnome/shell/extensions/kiwi/overview-wallpaper-background "false"
  dconf write /org/gnome/shell/extensions/kiwi/panel-transparency "false"
  ``` -->

:::::
::::::

### Personal recommendations

:::info Extensions with a more niche usecase that I recommend you to check out.
:::

::::::card
::::: collapse

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
  dconf write /org/gnome/shell/extensions/aztaskbar/isolate-workspaces "false"
  dconf write /org/gnome/shell/extensions/aztaskbar/main-panel-height "(true, 40)"
  dconf write /org/gnome/shell/extensions/aztaskbar/override-panel-clock-format "(true, '%a %R\\n%F')"
  dconf write /org/gnome/shell/extensions/aztaskbar/panel-location "'BOTTOM'"
  dconf write /org/gnome/shell/extensions/aztaskbar/show-apps-button "(true, 0)"

  # Requires Just Perfection extension; moves notifications to bottom right to match with task bar
  dconf write /org/gnome/shell/extensions/just-perfection/notification-banner-position "5"
  ```

  :::

- [Shotzy](https://extensions.gnome.org/extension/9707/shotzy/)

  :::info Image search on Google Lens, OCR and QR scan directly from the built-in GNOME Screenshot tool.
  :::

- [Kando Integration](https://extensions.gnome.org/extension/7068/kando-integration/)

  :::info Allows you to use the Kando Menu in Gnome Wayland sessions.
  :::

  :::demo-wrapper
  <video src="/assets/aiers-gnome/kando-marking-mode.mp4" autoplay loop muted playsinline onloadedmetadata="this.playbackRate=1.25"></video>
  :::

  :::note Follow [this](https://github.com/Theory-Y/tuxies-wiki/tree/master/resources/logitech-linux-setup/kando) link to download configuration files to achieve the effect in the above video.
  :::

  :::::
  ::::::

### Others

:::info Not in my setup, but you may like them.
:::

::::::card
::::: collapse

- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)

  ::: info Moves the dash out of overview into a dock for quicker app launching and window switching.
  ![Dash to Dock Demonstration](/assets/aiers-gnome/dash-to-dock-demonstration.png)
  :::

  :::tip My settings:
  Go to the extension's settings --> Appearances, turn on `Shrink the dash` to make the dash smaller and slicker.
  :::

- [Alphabetical App Grid](https://extensions.gnome.org/extension/4269/alphabetical-app-grid/)

  ::: info Sorts the app grid alphabetically to make apps easier to find.
  ![Alphabetical App Grid Demonstration](/assets/aiers-gnome/alphabetical-app-grid-demonstration.png)
  :::

  :::tip My settings:
  ==Position of ordered folders --> Start==, to make folders appear before apps.
  :::

- [GTK4 Desktop Icon NG](https://extensions.gnome.org/extension/5263/gtk4-desktop-icons-ng-ding/)

  :::info Allows for links, folders, and files in the desktop.
  ![DING4 Demo](/assets/aiers-gnome/ding4-demo.png)
  :::

- [Show Desktop Plus](https://extensions.gnome.org/extension/9756/show-desktop-plus/) _(QoL additions to GTK4 Desktop Icons NG)_

  :::info A button that shows your desktop, hiding all other windows. (Just like clicking the bottom right corner or `Super` + `D` in Windows)

  <video src="/assets/aiers-gnome/show-desktop-plus-demo.mp4" autoplay loop muted playsinline onloadedmetadata="this.playbackRate=1.25"></video>

  ```bash
  dconf write /org/gnome/shell/extensions/show-desktop-plus/button-position "'right-end'"
  dconf write /org/gnome/shell/extensions/show-desktop-plus/enable-hotkey true # Super + D to show desktop
  ```

  :::

:::::
::::::

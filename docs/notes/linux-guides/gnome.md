---
title: Gnome Guide
createTime: 2025/06/07 16:35:26
permalink: /linux-guides/gnome/
contributors:
  - aier
---

<!-- ::: note Why Gnome?
Gnome is clean and highly functional (though it follows quite a strict and somewhat stubborn philosophy). The Gnome workflow may be quite different compared what you are used to, but once you have gotten the hang of it, you may just fall in love.

==Read over this guide to customise Gnome to your liking!==
::: -->

::::card-grid
:::card title="Read after this" icon="fluent-emoji-flat:open-book"

[Further Gnome Customisation](/guides/gnome-further-customisation/)

Check out ==more extensions, settings, and tips== to make more out of Gnome!
:::
::::

<!-- ::: info You may have been looking for:
[Linux Guides Homepage](/linux-guides/) to see more distros and desktop environments.

::: -->

## **First steps**

### **Go through the `Settings` app and make some quick tweaks to your needs.**

:::card

- ==Display== — Adjust refresh rate and resolution as needed.
- ==Power== — Change performance mode, show battery %, change suspend behaviour, and more.
- ==Multitasking== — Adjust according to your workflow.
- ==Appearance== — You can add your own wallpaper and change to dark mode.
- ==Online Accounts== — You can connect to your online accounts to access calendar, cloud drives, and more within Gnome apps.
- ==Mouse & Trackpad== — You can change pointer sensitivity and turn acceleration on/off.
- ==Keyboard== — Add and modify keyboard shortcuts and change keyboard input settings.
  :::

:::tip See also
Check out the [External Resources](/guides/external-resources/) page for additional fixes, including a touchpad scrolling sensitivity fix for Gnome.
:::

### **Install some apps for more advanced options**

:::::::card

:::tip You can always use your distro's GUI software store (such as Gnome's `Software` instead of the terminal).
:::

:::tip Install these apps if you wish to unlock settings changes that are not easily accessible with the stock `Settings` app.
:::

:::::collapse accordion

- `Gnome Tweaks`

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install gnome-tweaks
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  sudo pacman -S gnome-tweaks
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install gnome-tweaks
  ```

  :::

  ![Gnome Tweaks](/assets/gnome/gnome-tweaks.png)

- `Dconf Editor`

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install dconf-editor
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  sudo pacman -S dconf-editor
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install dconf-editor
  ```

  :::

  ![Dconf Editor](/assets/gnome/dconf-editor.png)

- `Extension Manager`

  :::tabs

  @tab Flatpak (System)

  ```bash
  flatpak install flathub com.mattjakeman.ExtensionManager
  ```

  @tab Flatpak (User)

  ```bash
  flatpak install --user flathub com.mattjakeman.ExtensionManager
  ```

  :::

  ![Extension Manager](/assets/gnome/extension-manager.png)

:::::::

## **Basics**

:::::::card

:::tip All settings in `Gnome Tweaks` can be made through `Dconf Editor` (which you have downloaded) or `gsettings` (cli).
:::

::::details Quick append

:::tabs

@tab ::mdi:terminal:: Append changes (cli)

```bash
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
```

@tab ::mdi:reload:: Reset changes (cli)

```bash
gsettings reset org.gnome.desktop.wm.preferences button-layout
gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
gsettings reset org.gnome.mutter experimental-features
```

:::

::::

::::::collapse accordion

- Enable maximise and minimise title bar buttons

  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
  ```

  @tab ::mdi:puzzle:: Append changes (Gnome Tweaks)

  `Windows` > `Maximise` --> ==on==

  `Windows` > `Minimise` --> ==on==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.wm.preferences button-layout
  ```

  :::

  ![Gnome Tweaks Title Bar Settings](/assets/gnome/gnome-tweaks-title-bar-settings.png)

- Volume overamplification

  :::info Allows volume from your desktop to be amplified beyond 100% at the cost of distortion.
  :::

  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
  ```

  @tab ::mdi:file-settings:: Append changes (Dconf Editor)

  `/org/gnome/desktop/sound/allow-volume-above-100-percent`

  --> ==true==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent
  ```

  :::

- Enable Fractional Scaling Flag

  :::info Fractional scaling is enabled in most modern distros, but some apps do not work correctly as of Gnome 50 unless you toggle this flag on.
  :::

  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
  ```

  @tab ::mdi:file-settings:: Append changes (Dconf Editor)

  `/org/gnome/mutter/experimental-features`

  --> ==scale-monitor-framebuffer==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.mutter experimental-features
  ```

  :::

  ::::::

:::::::

### **Append useful keyboard shortcuts**

:::::::card

:::tip All following settings can be appended through `Dconf Editor` or `gsettings`.
:::

:::::details Quick append & shortcut cheatsheet (safe)

Use the following to append all keyboard shortcuts covered in this section.

::::tabs

@tab ::mdi:terminal:: Append changes (cli)

```bash
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left', '<Super>Page_Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right', '<Super>Page_Down']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super>bracketleft']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super>bracketright']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Alt><Shift>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Super><Shift>Tab']"
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>I', '<Super>semicolon']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>E']"
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>R']"
gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super><Shift>Return']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>F']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>X', '<Alt>F4']"
```

@tab ::mdi:reload:: Reset changes (cli)

```bash
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-left
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-right
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-left
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-right
gsettings reset org.gnome.desktop.wm.keybindings switch-windows
gsettings reset org.gnome.desktop.wm.keybindings switch-windows-backward
gsettings reset org.gnome.desktop.wm.keybindings switch-applications
gsettings reset org.gnome.desktop.wm.keybindings switch-applications-backward
gsettings reset org.gnome.settings-daemon.plugins.media-keys control-center
gsettings reset org.gnome.settings-daemon.plugins.media-keys home
gsettings reset org.gnome.desktop.wm.keybindings panel-run-dialog
gsettings reset org.gnome.desktop.wm.keybindings move-to-center
gsettings reset org.gnome.desktop.wm.keybindings toggle-fullscreen
gsettings reset org.gnome.desktop.wm.keybindings close
```

::::

| Keybinding                     | Shortcut                                     |
| ------------------------------ | -------------------------------------------- |
| `Ctrl` + `Super` + `Arrow`     | Switch workspaces                            |
| `Super` + `Bracket`            | Move a window to the workspace left or right |
| `Alt` + `Tab`                  | Switch windows                               |
| `Super` + `Tab`                | Switch apps                                  |
| `Super` + `I` or `Super` + `;` | Launch `Settings` app                        |
| `Super` + `E`                  | Launch home folder                           |
| `Super` + `R`                  | Run command dialog                           |
| `Super` + `Shift` + `Return`   | Centre window                                |
| `Super` + `F`                  | Fullscreen window                            |
| `Super` + `X`                  | Close window                                 |

:::::

:::::details Quick append & shortcut cheatsheet (all)

Use the following to append all keyboard shortcuts covered in this section. Keep in mind that some shortcuts would not be valid as you may need to install dependencies. Finish reading this section to learn more.

:::caution Quick append will erase ALL shortcuts you've appended in the custom section!
:::

::::tabs

@tab ::mdi:terminal:: Append changes (cli)

```bash
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left', '<Super>Page_Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right', '<Super>Page_Down']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super>bracketleft']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super>bracketright']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Alt><Shift>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Super><Shift>Tab']"
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>I', '<Super>semicolon']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>E']"
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>R']"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-ptyxis/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-mission-center/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-ptyxis/ binding "<Super>Return"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-ptyxis/ command ptyxis
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-ptyxis/ name "Launch Ptyxis"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-ptyxis/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-mission-center/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-mission-center/ binding "<Control><Shift>Escape"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-mission-center/ command "flatpak run io.missioncenter.MissionCenter"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-mission-center/ name "Launch Mission Center"
gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super><Shift>Return']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>F']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>X', '<Alt>F4']"
flatpak install io.missioncenter.MissionCenter -y
```

@tab ::mdi:reload:: Reset changes (cli)

```bash
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-left
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-right
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-left
gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-right
gsettings reset org.gnome.desktop.wm.keybindings switch-windows
gsettings reset org.gnome.desktop.wm.keybindings switch-windows-backward
gsettings reset org.gnome.desktop.wm.keybindings switch-applications
gsettings reset org.gnome.desktop.wm.keybindings switch-applications-backward
gsettings reset org.gnome.settings-daemon.plugins.media-keys control-center
gsettings reset org.gnome.settings-daemon.plugins.media-keys home
gsettings reset org.gnome.desktop.wm.keybindings panel-run-dialog
gsettings reset-recursively org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-ptyxis/
gsettings reset-recursively org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/launch-mission-center/
gsettings reset org.gnome.desktop.wm.keybindings move-to-center
gsettings reset org.gnome.desktop.wm.keybindings toggle-fullscreen
gsettings reset org.gnome.desktop.wm.keybindings close
```

::::

| Keybinding                     | Shortcut                                     |
| ------------------------------ | -------------------------------------------- |
| `Ctrl` + `Super` + `Arrow`     | Switch workspaces                            |
| `Super` + `Bracket`            | Move a window to the workspace left or right |
| `Alt` + `Tab`                  | Switch windows                               |
| `Super` + `Tab`                | Switch apps                                  |
| `Super` + `I` or `Super` + `;` | Launch `Settings` app                        |
| `Super` + `E`                  | Launch home folder                           |
| `Super` + `R`                  | Run command dialog                           |
| `Super` + `Return`             | Launch `Ptyxis` terminal                     |
| `Ctrl` + `Shift` + `Esc`       | Launch `Mission Center`                      |
| `Super` + `Shift` + `Return`   | Centre window                                |
| `Super` + `F`                  | Fullscreen window                            |
| `Super` + `X`                  | Close window                                 |

:::::

::::::collapse accordion

- Switch workspaces (Windows-like)

  `Ctrl` + `Super` + `Arrow`
  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  # Also preserving the original keybinding
  # <Super>Page_Up/Page_Down here because it is
  # quite useful on a full-sized keyboard.
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left', '<Super>Page_Up']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right', '<Super>Page_Down']"
  ```

  @tab ::mdi:file-settings:: Append changes (Dconf Editor)

  `/org/gnome/desktop/wm/keybindings/switch-to-workspace-left`

  --> ==\['\<Control\>\<Super\>Left'\]==

  `/org/gnome/desktop/wm/keybindings/switch-to-workspace-right`

  --> ==\['\<Control\>\<Super\>Right'\]==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-left
  gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-right
  ```

  :::

- Move a window to the workspace left or right

  `Super` + `[`

  `Super` + `]`

  ::::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super>bracketleft']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super>bracketright']"
  ```

  @tab ::mdi:file-settings:: Append changes (Dconf Editor)

  `/org/gnome/desktop/wm/keybindings/move-to-workspace-left`

  --> ==\['\<Super\>bracketleft'\]==

  `/org/gnome/desktop/wm/keybindings/move-to-workspace-right`

  --> ==\['\<Super\>bracketright'\]==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-left
  gsettings reset org.gnome.desktop.wm.keybindings move-to-workspace-right
  ```

  ::::

- More powerful `Alt–Tab` and `Super–Tab`

  `Alt` + `Tab` switches windows

  `Super` + `Tab` switches apps

  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Alt><Shift>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Super><Shift>Tab']"
  ```

  @tab ::mdi:file-settings:: Append changes (Dconf Editor)

  `/org/gnome/desktop/wm/keybindings/switch-windows`

  --> ==\['\<Alt\>Tab'\]==

  `/org/gnome/desktop/wm/keybindings/switch-windows-backward`

  --> ==\['\<Alt\>\<Shift\>Tab'\]==

  `/org/gnome/desktop/wm/keybindings/switch-applications`

  --> ==\['\<Super\>Tab'\]==

  `/org/gnome/desktop/wm/keybindings/switch-applications-backward`

  --> ==\['\<Super\>\<Shift\>Tab'\]==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.wm.keybindings switch-windows
  gsettings reset org.gnome.desktop.wm.keybindings switch-windows-backward
  gsettings reset org.gnome.desktop.wm.keybindings switch-applications
  gsettings reset org.gnome.desktop.wm.keybindings switch-applications-backward
  ```

  :::

- Launch `Settings` app (Windows-like)

  Because `Super` + `I` may not work due to interference with other shortcuts, `Super` + `;` is also provided here.

  `Super` + `I`

  `Super` + `;`

  ::::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>I', '<Super>semicolon']"
  ```

  @tab ::mdi:file-settings:: Append changes (Dconf Editor)

  `/org/gnome/settings-daemon/plugins/media-keys/control-center`

  --> ==\['\<Super\>I', '\<Super\>semicolon'\]==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.settings-daemon.plugins.media-keys control-center
  ```

  ::::

- Launch home folder (Windows-like)

  `Super` + `E`

  ::::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>E']"
  ```

  @tab ::mdi:file-settings:: Append changes (Dconf Editor)

  `/org/gnome/settings-daemon/plugins/media-keys/home`

  --> ==\['\<Super\>E'\]==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.settings-daemon.plugins.media-keys home
  ```

  ::::

- Run command dialog (Windows-like)

  `Super` + `R`

  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>R']"
  ```

  @tab ::mdi:file-settings:: Append changes (Dconf Editor)

  `/org/gnome/desktop/wm/keybindings/panel-run-dialog`

  --> ==\['\<Super\>R'\]==

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.wm.keybindings panel-run-dialog
  ```

  :::

- Centre window

  `Super` + `Shift` + `Return`

  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super><Shift>Return']"
  ```

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.wm.keybindings move-to-center
  ```

  :::

- Toggle fullscreen (universal)

  `Super` + `F`

  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>F']"
  ```

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.wm.keybindings toggle-fullscreen
  ```

  :::

- Close window (ergonomic)

  `Super` + `X`

  :::tabs

  @tab ::mdi:terminal:: Append changes (cli)

  ```bash
  gsettings set org.gnome.desktop.wm.keybindings close "['<Super>X', '<Alt>F4']"
  ```

  @tab ::mdi:reload:: Reset changes (cli)

  ```bash
  gsettings reset org.gnome.desktop.wm.keybindings close
  ```

  :::

  ::::::

:::caution Appending the following changes will override all shortcuts you've added in the `Settings`'s custom section. It is suggested that you append them manually through the `Gnome Settings` app --> `Keyboard` --> `View and Customise Keyboard Shortcuts` section instead if you have existing custom shortcuts.
:::

::::::collapse accordion

- Launch `Ptyxis` Terminal

  `Super` + `Return`

  ==Install dependencies==

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install ptyxis
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  pacman -S ptyxis
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install ptyxis
  ```

  :::

- Launch `Mission Center` (Windows-like)

  `Ctrl` + `Shft` + `Esc`

  ==Install dependencies==

  ::::tabs

  @tab Flatpak (System)

  ```bash
  flatpak install flathub io.missioncenter.MissionCenter
  ```

  @tab Flatpak (User)

  ```bash
  flatpak install --user flathub io.missioncenter.MissionCenter
  ```

  ::::

::::::

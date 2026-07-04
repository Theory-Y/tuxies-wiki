---
title: Better Text Rendering (Gnome Hi-DPI)
tags:
  - Beginner
  - Gnome
  - Fixes
createTime: 2025/07/18 20:31:18
permalink: /guides/better-text-rendering-gnome-hi-dpi/
---

:::info Sets font hinting to "slight" and antialiasing to "standard".
:::

:::tabs

@tab ::mdi:terminal:: Append changes (cli)

```bash
gsettings set org.gnome.desktop.interface font-antialiasing grayscale
gsettings set org.gnome.desktop.interface font-hinting slight
```

@tab ::mdi:puzzle:: Append changes (Gnome Tweaks)

`Fonts` > `Rendering` > `Hinting` --> ==slight==

`Fonts` > `Rendering` > `Antialiasing` --> ==Standard Grayscale==

@tab ::mdi:reload:: Reset changes (cli)

```bash
gsettings reset org.gnome.desktop.interface font-antialiasing
gsettings reset org.gnome.desktop.interface font-hinting
```

:::

![Gnome Tweaks Font Redering Settings](/assets/better-text-rendering-gnome-hi-dpi/gnome-tweaks-font-rendering-settings.png)

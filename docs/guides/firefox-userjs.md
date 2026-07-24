---
tags:
  - Beginner
  - Browsers
  - Productivity
  - Fixes
title: Firefox Advanced Settings Tweaks (user.js)
createTime: 2025/05/22 09:05:08
permalink: /guides/firefox-userjs/
contributors:
  - aier
---

:::tip
This preset has a few changes you can make to your `user.js` that will make your Firefox-based experience on Linux much more polished.
:::

## **Master Quick Append**

Copy the whole thing, or pick out the lines you want. Each line has a short comment explaining what it does; the value after `//` is the default.

:::code-tabs
@tab user.js

```js
// Mouse Scrolling
user_pref("mousewheel.default.delta_multiplier_x", 200); // 100 — mousewheel speed (higher = faster)
user_pref("mousewheel.default.delta_multiplier_y", 200); // 100
user_pref("mousewheel.default.delta_multiplier_z", 200); // 100
user_pref("general.autoScroll", true); // false — middle-click autoscroll (off on Linux by default)

// Touchpad Scrolling 
user_pref("apz.fling_friction", "0.004");         // "0.002" — trackpad scroll drag (higher = stops sooner)
user_pref("apz.gtk.pangesture.delta_mode", 2);    // Default 0. 2 respects display scaling
// Touchpad speed — prefer a system-wide fix instead
// user_pref("apz.gtk.pangesture.pixel_delta_mode_multiplier", "7"); // Default "40.0". Trackpad-only speed

// Other Settings
user_pref("browser.tabs.hoverPreview.enabled", true);           // false — show tab preview on hover
user_pref("browser.tabs.hoverPreview.showThumbnails", true);    // false — include a thumbnail in that preview

// Zen Browser–specific settings
user_pref("zen.workspaces.separate-essentials", false);    // true — share essentials across all workspaces
// user_pref("zen.view.show-newtab-button-top", false);    // true — move new-tab button to top of tab list
user_pref("browser.tabs.fadeOutUnloadedTabs", true);       // false — dim inactive/unloaded tabs
```

:::

:::tip Prefer a system-wide touchpad fix
Adjusting touchpad scroll speed at the system level applies everywhere, not just in Firefox (usually the better option). See the [touchpad scrolling sensitivity fix](/guides/external-resources/) on our External Resources page. The commented `apz.gtk.pangesture.*` lines are only for tweaking trackpad behaviour inside Firefox specifically.
:::

:::warning Flatpak Zen
If you installed Zen via Flatpak, its profile folder isn't reachable from `about:support`. Find it (and place your `user.js`) under `~/.var/app/app.zen_browser.zen/.zen/XXXXX/`, where `XXXXX` is your profile ID.
:::

## **How to append changes**

### **Method 1: `user.js` config file (faster)**

::::steps

- **Create a `user.js` by typing "about:support" into your browser and clicking "Open Directory" in the Profile Directory row.**

  :::demo-wrapper img
  ![Firefox Profile Directory](/assets/firefox-userjs/firefox-profile-directory.png)
  :::

- **Inside your profile folder, you can create a file named `user.js` if it does not exist already. You can append changes from this guide into `user.js`.**

::::

### **Method 2: "about:config"**

::::steps

- **Type in "about:config" into your browser and you'll be taken to the Firefox advanced preference page. Press "Accept risk and continue".**

  :::demo-wrapper img
  ![Firefox about:config page](/assets/firefox-userjs/firefox-about-config.png)
  :::

- **You can then type in the search bar the preference mentioned in the guide, edit the values of the preference, and create the reference if it doesn't exist.**

::::

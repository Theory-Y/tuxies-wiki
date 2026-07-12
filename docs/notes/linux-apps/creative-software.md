---
Title: Creative Software
createTime: 2025/12/10 15:07:59
permalink: /linux-apps/creative-software/
contributors:
  - aier
  - Lunear
---

## **[Blender](https://www.blender.org/download/)**

3D creation suite for modelling, animation, visual effects, and video editing

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub org.blender.Blender
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub org.blender.Blender
```

:::

## **[Inkscape](https://flathub.org/apps/org.inkscape.Inkscape)**

Open souce vector graphic editor

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub org.inkscape.Inkscape
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user org.inkscape.Inkscape
```

:::

## **[Darktable](https://www.darktable.org/)**

"Darktable is an open source photography workflow application and raw developer. A virtual lighttable and darkroom for photographers. It manages your digital negatives in a database, lets you view them through a zoomable lighttable and enables you to develop raw images and enhance them."

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub org.darktable.Darktable
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub org.darktable.Darktable
```

:::

### **Non-flatpak install**

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install darktable
```

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S darktable
```

@tab ::devicon:debian::Debian/Ubuntu

```bash
sudo apt install darktable
```

:::

## **[OBS Studio](https://flathub.org/apps/com.obsproject.Studio)**

Video recording and streaming.

:::tabs
@tab ::simple-icons:flatpak:: Flatpak(System)

```bash
flatpak install flathub com.obsproject.Studio
```

@tab ::simple-icons:flatpak:: Flatpak(User)

```bash
flatpak install --user flathub com.obsproject.Studio
```

:::

### [v4l2loopback (Virtual Camera and More)](https://github.com/umlaeute/v4l2loopback)

You would want to install v4l2loopback if you want to use the “virtual camera” function in OBS Studio.
::::steps

- Dependencies:

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install gcc kernel-devel dkms
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  sudo pacman -S v4l2loopback-dkms
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install dkms
  ```

  :::

- **Install Module & Run:**

  ```bash
  git clone https://github.com/umlaeute/v4l2loopback
  cd v4l2loopback
  make && sudo make install
  sudo depmod -a
  sudo modprobe v4l2loopback
  ```

- **Load module on startup:**

  Create the File `/etc/modules-load.d/v4l2loopback.conf` and write:

  ```bash
  v4l2loopback
  ```

  In the case where the “Virtual Camera” button doesn’t show on OBS, the system may not have loaded the module. You can either redo the installation, or try loading the the module manually with:

  ```bash
  sudo modprobe v4l2loopback
  ```

::::


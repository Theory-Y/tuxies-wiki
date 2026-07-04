---
Title: Dev (Computer Nerd) Tools
createTime: 2026/07/04 13:15:02
permalink: /linux-apps/dev-tools/
contributors:
  - aier9500
---

A collection of command-line, terminal, and tinkerer tools for the more technical crowd.

:::info Want a guided setup instead?
Our [Terminal Customisation (Bash)](/guides/terminal-customisation-bash/) offers presets and guides walks you through setting up `fastfetch`, `fzf`, `zoxide`, `eza`, and `yazi` end-to-end, including aliases and a custom prompt.
:::

## GUI

### **[Waydroid](https://docs.waydro.id/usage/install-on-desktops)**

Run Android on Linux!

Find out about installation details on the link above
:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install waydroid
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install curl ca-certificates -y
# Download the repo setup script, review it, then run it
# (safer than piping a remote script straight into sudo bash)
curl -o waydroid-setup.sh https://repo.waydro.id
less waydroid-setup.sh
sudo bash waydroid-setup.sh
sudo apt install waydroid -y
```

@tab ::devicon:archlinux:: Arch (AUR)

```bash
yay -S waydroid
```

:::

### **[SaveDesktop](https://flathub.org/apps/io.github.vikdevelop.SaveDesktop)**

Save your desktop

:::tabs

@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub io.github.vikdevelop.SaveDesktop
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub io.github.vikdevelop.SaveDesktop
```

:::

### **VS Code**

:::tabs
@tab ::simple-icons:flatpak:: Flatpak (System)

```bash
flatpak install flathub com.visualstudio.code
```

@tab ::simple-icons:flatpak:: Flatpak (User)

```bash
flatpak install --user flathub com.visualstudio.code
```

:::

#### **[VS Code Non-Flatpak Download](https://code.visualstudio.com/Download)**

If you have to avoid limitations imposed by using a Flatpak wrapper of VS Code, check the downloads methods below.

:::tabs

@tab ::devicon:fedora:: Fedora
Download .rpm file from link above

@tab ::devicon:debian:: Debian/Ubuntu
Download .deb file from link above

@tab ::devicon:archlinux:: Arch (Code - OSS)

```bash
sudo pacman -S code
```

:::

## TUI

### **[Yazi](https://github.com/sxyazi/yazi)**

`yazi` is a fast terminal file manager with image previews and fuzzy navigation.

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf copr enable lihaohong/yazi
sudo dnf install yazi
```

@tab ::devicon:debian:: Debian/Ubuntu

`yazi` is not in the stable `apt` repositories — install it via the Rust toolchain:

```bash
cargo install --locked yazi-fm yazi-cli
```

@tab ::devicon:archlinux:: Arch

```bash
pacman -S yazi
```

:::

See our [Yazi guide](/guides/yazi/) for keys, optional dependencies, and image-preview setup.

### **[Fresh](https://getfresh.dev/)**

A terminal-based text editor that feels like VS Code or Sublime Text, complete with multi-cursor editing, Git tools, and code completion — no configuration needed.

:::tabs

@tab ::devicon:fedora:: Fedora

Click the link in the title above for install details.

@tab ::devicon:debian:: Debian/Ubuntu

Click the link in the title above for install details.

@tab ::devicon:archlinux:: Arch (AUR)

```bash
yay -S fresh-editor-bin
```

@tab Universal script

Good practice: inspect the scripts before running them. Link to the script in the command is [here](https://raw.githubusercontent.com/sinelaw/fresh/refs/heads/master/scripts/install.sh).

```bash
curl https://raw.githubusercontent.com/sinelaw/fresh/refs/heads/master/scripts/install.sh | sh

```

:::

## CLI

### **[fastfetch](https://github.com/fastfetch-cli/fastfetch)**

`fastfetch` shows a quick snapshot of your system information (OS, CPU, GPU, and more) in your terminal.

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install fastfetch
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install fastfetch
```

@tab ::devicon:archlinux:: Arch

```bash
pacman -S fastfetch
```

:::

### **[fzf](https://github.com/junegunn/fzf)**

`fzf` is a fuzzy finder that helps you quickly search files, folders, and your command history right from the terminal.

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install fzf
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install fzf
```

@tab ::devicon:archlinux:: Arch

```bash
pacman -S fzf
```

:::

### **[zoxide](https://github.com/ajeetdsouza/zoxide)**

`zoxide` is a smarter version of `cd` that remembers your most-used folders, so you can jump straight to them with just a few letters.

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install zoxide
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install zoxide
```

@tab ::devicon:archlinux:: Arch

```bash
pacman -S zoxide
```

:::

### **[eza](https://github.com/eza-community/eza)**

`eza` is a modern, more colourful replacement for `ls` that can also display your files and folders as a tree.

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install eza
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install eza
```

@tab ::devicon:archlinux:: Arch

```bash
pacman -S eza
```

:::

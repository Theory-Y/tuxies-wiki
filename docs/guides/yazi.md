---
title: Yazi Terminal File Manager
tags:
  - Beginner
  - Yazi
  - Terminal
  - Productivity
createTime: 2026/06/11 16:25:00
permalink: /guides/yazi/
contributors:
  - aier9500
---

## **Installation**

### **Installing on your distro**

:::tabs

@tab ::devicon:fedora:: Fedora

Enable the COPR, then install:

```bash
sudo dnf copr enable lihaohong/yazi
sudo dnf install yazi
```

@tab ::devicon:debian:: Debian/Ubuntu

`yazi` is not in the stable `apt` repositories. The simplest portable method is via the Rust toolchain (works on any distro):

```bash
cargo install --locked yazi-fm yazi-cli
```

A community `.deb` repo also exists: [Yazi installation docs](https://yazi-rs.github.io/docs/installation/).

@tab ::devicon:archlinux:: Arch

```bash
sudo pacman -S yazi
```

:::

### **Optional dependencies**

These packages unlock previews, search, and jump features. Some of them are probably on your system already. Install whichever you need:

| Package       | Purpose                             |
| ------------- | ----------------------------------- |
| `ffmpeg`      | Video thumbnails                    |
| `7zip`        | Archive preview and extraction      |
| `jq`          | JSON preview                        |
| `poppler`     | PDF preview                         |
| `fd`          | File-name search                    |
| `ripgrep`     | File-content search                 |
| `fzf`         | Quick jump                          |
| `zoxide`      | Jump to recent directories          |
| `resvg`       | SVG preview                         |
| `imagemagick` | Extra image formats (HEIC, JPEG XL) |
| `nerd-fonts`  | Proper icon glyphs                  |

## **Quick tips and usage**

### **Essential keys**

| Key                                 | Action                                        |
| ----------------------------------- | --------------------------------------------- |
| `h` / `j` / `k` / `l` or arrow keys | Navigate left / down / up / right             |
| `q`                                 | Quit and return to the ==original== directory |
| `Q`                                 | Quit ==without== changing directory           |
| `.`                                 | Toggle hidden files                           |
| `f`                                 | Filter entries in current directory           |
| `s`                                 | Search by file name (requires `fd`)           |
| `S`                                 | Search by file content (requires `ripgrep`)   |
| `t`                                 | Open a new tab                                |
| `1` – `9`                           | Switch to tab by number                       |
| `[` / `]`                           | Cycle between tabs                            |

Check `yazi`'s [Quick Start](https://yazi-rs.github.io/docs/quick-start/) for more.

### **The `y` shell wrapper (cd-on-exit)**

By default, running `yazi` directly won't change your shell's working directory when you quit. The `y` wrapper function fixes this — your shell follows `yazi`'s last location on exit.

Add the following to `~/.bashrc` (or your shell's equivalent), then run `y` instead of `yazi`:

:::code-tabs

@tab ~/.bashrc

```bash
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
```

:::

After saving, reload your shell with `source ~/.bashrc` and use `y`.

### **Image previews**

`yazi` supports in-terminal image rendering and ==auto-detects== the best protocol for your terminal — no manual configuration needed.

:::tip For maximum compatibility, use Ghostty
`ghostty` implements the ==Kitty image protocol== (Unicode placeholders), which `yazi` supports natively and with zero extra configuration. See the [Ghostty Terminal guide](/guides/ghostty-terminal/) to get set up.
:::

### **Resizing image previews**

Image previews are configured in `yazi`'s own `~/.config/yazi/yazi.toml` — separate from your terminal's config. Two settings control how large a preview appears: the width of the preview pane and the maximum render resolution.

- `ratio` in the `[mgr]` section is the `[parent, current, preview]` column split (default `[1, 4, 3]`). ==Raise the third value== to give previews more room, for example `[1, 2, 5]`.
- `max_width` and `max_height` in the `[preview]` section cap the render resolution in pixels (defaults `600` and `900`). Increase them for larger, sharper images.

:::code-tabs

@tab ~/.config/yazi/yazi.toml

```toml
[mgr]
# widen the preview pane (default [1, 4, 3])
ratio = [1, 2, 5]

[preview]
# raise render resolution in pixels (defaults 600 x 900)
max_width = 1200
max_height = 1600
```

:::

`yazi` fits previews to the pane and ==re-renders automatically when you resize== the window — no toggle needed — on terminals that report their pixel size (`ghostty`, Kitty, foot). Terminals without this support fall back to the static `max_width` and `max_height` values.

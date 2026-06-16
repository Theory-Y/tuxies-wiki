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

:::note Quick append
You can also download ready-made files in this repo [here](https://github.com/Theory-Y/tuxies-wiki/tree/master/resources/yazi) and drop them into `~/.config/yazi/`.

Adjust the directory paths in `keymap.toml` to match your own home folders.
:::

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

### **Custom navigation shortcuts**

These optional configs extend the `g` (go-to) shortcuts with quick jumps to common directories, plus a high-contrast cheatsheet popup. The `theme.toml` uses the `Everforest Dark Hard` theme (also used in the [Ghostty Terminal guide](/guides/ghostty-terminal/)).

| Keys      | Jumps to          |
| --------- | ----------------- |
| `g` + `D` | `~/Documents`     |
| `g` + `p` | `~/Pictures`      |
| `g` + `v` | `~/Videos`        |
| `g` + `m` | `~/Music`         |
| `g` + `e` | `~/Desktop`       |
| `g` + `P` | `~/Public`        |
| `g` + `C` | `~/.config/yazi`  |
| `g` + `i` | `~/Installations` |
| `g` + `w` | `~/Projects`      |

:::tip
`g` + `i` (`~/Installations`) and `g` + `w` (`~/Projects`) point to ==custom folders==. Create them with `mkdir ~/Installations ~/Projects`, or edit those two paths in `keymap.toml` to suit your own setup.
:::

The `theme.toml` below is a ==partial== override — it changes only the `[which]` popup, so other elements are `yazi` default.

::::details Custom config files

:::code-tabs

@tab ~/.config/yazi/keymap.toml

```toml
# Custom g-prefix navigation. prepend_keymap = sits ahead of defaults.
# Kept defaults: g h (home), g c (~/.config), g d (Downloads), g t (/tmp), g g (top)

# --- major home dirs (plain cd: deterministic, fast) ---

[[mgr.prepend_keymap]]
on   = [ "g", "e" ]
run  = "cd ~/Desktop"
desc = "Go to Desktop"

[[mgr.prepend_keymap]]
on   = [ "g", "D" ]
run  = "cd ~/Documents"
desc = "Go to Documents"

[[mgr.prepend_keymap]]
on   = [ "g", "p" ]
run  = "cd ~/Pictures"
desc = "Go to Pictures"

[[mgr.prepend_keymap]]
on   = [ "g", "v" ]
run  = "cd ~/Videos"
desc = "Go to Videos"

[[mgr.prepend_keymap]]
on   = [ "g", "m" ]
run  = "cd ~/Music"
desc = "Go to Music"

[[mgr.prepend_keymap]]
on   = [ "g", "P" ]
run  = "cd ~/Public"
desc = "Go to Public"

[[mgr.prepend_keymap]]
on   = [ "g", "C" ]
run  = "cd ~/.config/yazi"
desc = "Go to yazi config"

# --- custom directories ---

[[mgr.prepend_keymap]]
on   = [ "g", "i" ]
run  = "cd ~/Installations"
desc = "Go to Installations"

[[mgr.prepend_keymap]]
on   = [ "g", "w" ]
run  = "cd ~/Projects"
desc = "Go to Projects"
```

@tab ~/.config/yazi/theme.toml

```toml
# Partial override — only [which] is changed; everything else uses yazi defaults.
# Fixes the low-contrast g/which-key cheatsheet popup. Palette = Everforest Dark
# Hard, matching the Ghostty terminal theme.

[which]
cols = 3
# raised panel (bg2) above the hard background #1e2326 so the popup stands out
mask            = { bg = "#2e383c" }
# the highlighted next-key candidate(s) — everforest yellow, bold
cand            = { fg = "#dbbc7f", bold = true }
# remaining keys of a pending multi-key sequence — muted grey
rest            = { fg = "#a6b0a0" }
# the action description text — everforest foreground for readability
desc            = { fg = "#d3c6aa" }
separator       = "  "
separator_style = { fg = "#7a8478" }
```

:::

::::

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

---
title: Terminal Customisation
tags:
  - Intermediate
  - Terminal
  - Ricing
createTime: 2025/05/22 09:05:08
permalink: /guides/terminal-customisation/
contributors:
  - aier
  - Lunear
---

:::info
This guide will walk you through customising your Bash prompt, how to run `fastfetch` on start in your terminal, and a few useful terminal programs.
:::

:::demo-wrapper img
![Terminal preview](/assets/terminal-customisation/terminal-preview.png)
:::

:::danger
This tutorial assumes that you are using Bash as your shell, even though some part of the tutorial may apply to non-Bash shells.

==For non-Bash users, we cannot guarantee success and will not take responsibility to damages to your system.==
:::

::::details Master quick append (Bash)

Paste into `~/.bashrc`. Each option is explained in the sections below.

:::code-tabs

@tab ~/.bashrc

```bash
#### autorun fastfetch ####
fastfetch

#### custom PS1 prompt ####
PS1='------------------\n\[$(tput setaf 26)\][\[$(tput setaf 32)\]\u \[$(tput setaf 38)\]@ \[$(tput setaf 44)\]\h\[$(tput setaf 26)\]] \[$(tput setaf 75)\]\w\[$(tput sgr0)\]\n > '

#### quick config edit ####
alias edit-bash='$EDITOR ~/.bashrc' # edit this file with your default editor

#### fzf-related aliases ####
alias show-commands='compgen -c | fzf' # show all commands
alias search-history='history | fzf' # search in bash command history

#### enabling zoxide ####
eval "$(zoxide init bash)"

#### yazi: cd-on-exit wrapper ####
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
```

:::

::::

::::details Master quick append (Fish)

Quick install:

:::tabs

@tab ::devicon:fedora:: Fedora

```bash
sudo dnf install fish
```

@tab ::devicon:debian:: Debian/Ubuntu

```bash
sudo apt install fish
```

@tab ::devicon:archlinux:: Arch

```bash
pacman -S fish
```

:::

Then set `fish` as your default shell (log out and back in for it to take effect):

```bash
chsh -s $(which fish)
```

Fish loads functions on demand from `~/.config/fish/functions/`.

```fish
mkdir -p ~/.config/fish/functions
```

In `~/.config/fish/`:

:::code-tabs

@tab config.fish

```fish
if status is-interactive
    #### disable welcome greeting ####
    set -g fish_greeting

    #### autorun fastfetch ####
    fastfetch

    #### quick config edit ####
    alias edit-fish='$EDITOR ~/.config/fish/config.fish' # edit this file with your default editor

    #### fzf-related aliases ####
    alias show-commands='complete -C "" | fzf' # show all commands
    alias search-history='history | fzf' # search in fish command history

    #### enabling zoxide ####
    zoxide init fish | source
end
```

@tab functions/fish_prompt.fish

```fish
#### custom prompt ####
function fish_prompt
    echo '------------------'
    echo (set_color 005fd7)'['(set_color 0087d7)$USER(set_color 00afd7)' @ '(set_color 00d7d7)(hostname)(set_color 005fd7)'] '(set_color 5fafff)(prompt_pwd)(set_color normal)
    echo -n ' > '
end
```

@tab functions/y.fish

```fish
#### yazi: cd-on-exit wrapper ####
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end
```

:::

::::

## **Back up current `.bashrc`**

Make a copy of your current `.bashrc` file and place it somewhere safe.

```bash
cp ~/.bashrc ~/.bashrc.bak # Makes a copy of current .bashrc file named .bashrc.bak
```

Make sure that you have a `.bashrc` file in your `/home/$USER/` at all times. If you followed the command above, you'd be fine.

You'll be editing the `.bashrc` file from your home directory in this guide, but if you ever want/need to revert back to the original file, simply replace the content in `.bashrc` from the backup you've made.

:::::details Here is an exemplar `.bashrc` file taken from my Fedora 42 Workstation (hopefully you don't have to use this):

:::code-tabs

@tab .bashrc

```bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
```

:::

:::::

## **Aesthetic Changes**

:::::details Quick append

Your `.bashrc` should look something like this if you decide to follow all instructions in the following section:

::: code-tabs

@tab .bashrc

```bash
# ... omitted original .bashrc content above

fastfetch

PS1='------------------\n\[$(tput setaf 26)\][\[$(tput setaf 32)\]\u \[$(tput setaf 38)\]@ \[$(tput setaf 44)\]\h\[$(tput setaf 26)\]] \[$(tput setaf 75)\]\w\[$(tput sgr0)\]\n > '
```

:::

:::::

### **Autorun `fastfetch`** when you open the terminal

You can make your bash terminal autorun `fastfetch` to display system information every time it starts by appending the following at the bottom of your file.

:::::steps

- **Installation**

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install fastfetch
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  pacman -S fastfetch
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install fastfetch
  ```

  :::

- **Set up `fastfetch` in shell**

  You can append the following at the bottom of your `.bashrc`:

  :::code-tabs
  @tab .bashrc

  ```bash
  fastfetch
  ```

  :::

- **Apply the Tuxie's Wiki config _(optional)_**

  For a Tuxie's Wiki-branded fastfetch — the Tux mascot in monochrome with steel-blue accents — download [this `config.jsonc`](/assets/terminal-customisation/theoryy-fastfetch-config.zip), extract it, and save it to `~/.config/fastfetch/config.jsonc`. fastfetch picks it up automatically.

- **Changing the look of the prompt (`PS1`)**

  Now, in your `.bashrc`, you change the looks of your prompt looks through modifying the `PS1` variable.

  You can append the following at the bottom of your `.bashrc`:

  :::code-tabs
  @tab .bashrc

  ```bash
  PS1='------------------\n\[$(tput setaf 26)\][\[$(tput setaf 32)\]\u \[$(tput setaf 38)\]@ \[$(tput setaf 44)\]\h\[$(tput setaf 26)\]] \[$(tput setaf 75)\]\w\[$(tput sgr0)\]\n > '
  ```

  :::

- **More resources**
  - [`PS1` customisation by Rahul from tecadmin.net](https://tecadmin.net/how-to-customize-bash-prompt-ps1-in-linux/)

:::::

## **Terminal programs**

:::::details Quick append

Your `.bashrc` should look something like this if you decide to follow all instructions in the following section:

:::code-tabs
@tab .bashrc

```bash
# ... omitted original .bashrc content above

#### fzf-related aliases ####
alias show-commands='compgen -c | fzf' # show all commands
alias search-history='history | fzf' # search in bash command history

#### enabling zoxide ####
eval "$(zoxide init bash)"

#### yazi: cd-on-exit wrapper ####
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
```

:::

:::::

### **Using `fzf`** (Fuzzy Find)

:::tip What is `fzf`?

`fzf` is a command-line fuzzy finder that helps you quickly search and navigate files, directories, command history, and more.
:::

::::steps

- **Installation**

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install fzf
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  pacman -S fzf
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install fzf
  ```

  :::

- **Add aliases**

  Below are example aliases:

  :::code-tabs

  @tab .bashrc

  ```bash
  alias show-commands='compgen -c | fzf' # show all commands
  alias search-history='history | fzf' # search in bash command history
  ```

  :::

- **More resources**
  - [Tutorial](https://youtu.be/MvLQor1Ck3M?si=t23i-fsLL57QyuzU&t=50) on how to use `fzf` by DevOps Toolbox
  - [Use `fzf` with `zoxide`](https://www.youtube.com/watch?v=aghxkpyRVDY) by Dreams of Autonomy
  - [More info](https://github.com/junegunn/fzf?tab=readme-ov-file) about `fzf` from the official `fzf` GitHub page.

::::

### **Using `zoxide`**

:::tip What is `zoxide`?
`zoxide` is a terminal program that is like `cd` on steroids. It provides `cd`'s functionality with the addition of being able to jump to directories with short, fuzzy-matched commands.
:::

::::steps

- **Installation**

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install zoxide
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  pacman -S zoxide
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install zoxide
  ```

  :::

- **Set up `zoxide` in your Bash shell**

  Append the following to your `.bashrc`:

  :::code-tabs
  @tab .bashrc

  ```bash
  eval "$(zoxide init bash)"
  ```

  :::

- **More resources**
  - [Tutorial](https://www.youtube.com/watch?v=aghxkpyRVDY&t=83s) on how to use `zoxide` by Dreams of Autonomy (includes how to use it with `fzf`, too)
  - [More info](https://github.com/ajeetdsouza/zoxide) about `zoxide` from the official `zoxide` GitHub page

::::

### **Using `yazi`**

:::tip What is `yazi`?
`yazi` is a fast terminal file manager with image previews, fuzzy navigation, and plugin support.
:::

:::::steps

- **Installation**

  ::::tabs

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

  ::::

- **Add the `y` shell wrapper**

  The `y` function launches `yazi` and changes your shell to its last directory on exit. Append it to your `.bashrc`:

  :::code-tabs

  @tab .bashrc

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

  Reload with `source ~/.bashrc`, then run `y` instead of `yazi`.

- **More resources**
  - See our [Yazi guide](/guides/yazi/) for keys, optional dependencies, and image-preview setup
  - [`yazi` documentation](https://yazi-rs.github.io/docs/quick-start/)

:::::

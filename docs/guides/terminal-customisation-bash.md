---
title: Terminal Customisation (Bash)
tags:
  - Intermediate
  - Terminal
  - Ricing
createTime: 2025/05/22 09:05:08
permalink: /guides/terminal-customisation-bash/
contributors:
  - aier
  - Lunear
---

:::info
This guide will walk you through customising your Bash prompt, how to run `fastfetch` on start in your terminal, and a few useful terminal programs.
:::

:::danger
This tutorial assumes that you are using Bash as your shell, even though some part of the tutorial may apply to non-Bash shells.

==For non-Bash users, we cannot guarantee success and will not take responsibility to damages to your system.==
:::

::::details Master quick append

Paste into `~/.bashrc`. Each option is explained in the sections below.

:::code-tabs

@tab ~/.bashrc

```bash
#### autorun fastfetch ####
fastfetch

#### custom PS1 prompt ####
PS1='------------------\n\[$(tput setaf 26)\][\[$(tput setaf 32)\]\u \[$(tput setaf 38)\]@ \[$(tput setaf 44)\]\h\[$(tput setaf 26)\]] \[$(tput setaf 75)\]\w\[$(tput sgr0)\]\n > '

#### fzf-related aliases ####
alias cmd='compgen -c | fzf' # search for a possible command
alias zh='history | fzf' # search in bash command history

#### enabling zoxide ####
eval "$(zoxide init bash)"

#### eza-related aliases ####
# list directories in a tree format (or specify how many levels to list them)
alias lsd='eza -TD'
alias lsd1='eza -TD --level 1'
alias lsd2='eza -TD --level 2'
alias lsd3='eza -TD --level 3'
# list items in tree format (or specify how many levels to list them)
alias lst='eza -T'
alias lst1='eza -T --level 1'
alias lst2='eza -T --level 2'
alias lst3='eza -T --level 3'
# list all directories in tree format including hidden ones (or specify how many levels to list them)
alias lsda='eza -TDa'
alias lsda1='eza -TDa --level 1'
alias lsda2='eza -TDa --level 2'
alias lsda3='eza -TDa --level 3'
# list all items in tree format including hidden ones (or specify how many levels to list them)
alias lsta='eza -Ta'
alias lsta1='eza -Ta --level 1'
alias lsta2='eza -Ta --level 2'
alias lsta3='eza -Ta --level 3'

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

## **Back up current `.bashrc`**

Make a copy of your current `.bashrc` file and place it somewhere safe.

```bash
cp ~/.bashrc ~/.bashrc-original # Makes a copy of current .bashrc file named .bashrc-original
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

:::::details Quick append & preview

Your `.bashrc` should look something like this if you decide to follow all instructions in the following section:

::: code-tabs

@tab .bashrc

```bash
# ... omitted original .bashrc content above

fastfetch

PS1='------------------\n\[$(tput setaf 26)\][\[$(tput setaf 32)\]\u \[$(tput setaf 38)\]@ \[$(tput setaf 44)\]\h\[$(tput setaf 26)\]] \[$(tput setaf 75)\]\w\[$(tput sgr0)\]\n > '
```

:::

![Aesthetic Terminal](/assets/terminal-customisation-bash/aesthetic-terminal.png)

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

  and here is what it looks like:

  :::demo-wrapper img
  ![fastfetch](/assets/terminal-customisation-bash/fastfetch.png)
  :::

- **Apply the TheoryY config _(optional)_**

  For a TheoryY-branded fastfetch — the Tux mascot in monochrome with steel-blue accents — download [this `config.jsonc`](/assets/terminal-customisation-bash/theoryy-fastfetch-config.zip), extract it, and save it to `~/.config/fastfetch/config.jsonc`. fastfetch picks it up automatically.

- **Changing the look of the prompt (`PS1`)**

  Now, in your `.bashrc`, you change the looks of your prompt looks through modifying the `PS1` variable.

  You can append the following at the bottom of your `.bashrc`:

  :::code-tabs
  @tab .bashrc

  ```bash
  PS1='------------------\n\[$(tput setaf 26)\][\[$(tput setaf 32)\]\u \[$(tput setaf 38)\]@ \[$(tput setaf 44)\]\h\[$(tput setaf 26)\]] \[$(tput setaf 75)\]\w\[$(tput sgr0)\]\n > '
  ```

  :::

  and here is what it looks like:

  ![Custom PS1](/assets/terminal-customisation-bash/custom-ps1.png)

- **More resources**
  - [`PS1` customisation by Rahul from tecadmin.net](https://tecadmin.net/how-to-customize-bash-prompt-ps1-in-linux/)

:::::

## **Terminal programs**

:::::details Quick append & preview

Your `.bashrc` should look something like this if you decide to follow all instructions in the following section:

:::code-tabs
@tab .bashrc

```bash
# ... omitted original .bashrc content above

#### fzf-related aliases ####
alias cmd='compgen -c | fzf' # search for a possible command
alias zh='history | fzf' # search in bash command history

#### enabling zoxide ####
eval "$(zoxide init bash)"

#### eza-related aliases ####
# list directories in a tree format (or specify how many levels to list them)
alias lsd='eza -TD'
alias lsd1='eza -TD --level 1'
alias lsd2='eza -TD --level 2'
alias lsd3='eza -TD --level 3'
# list items in tree format (or specify how many levels to list them)
alias lst='eza -T'
alias lst1='eza -T --level 1'
alias lst2='eza -T --level 2'
alias lst3='eza -T --level 3'
# list all directories in tree format including hidden ones (or specify how many levels to list them)
alias lsda='eza -TDa'
alias lsda1='eza -TDa --level 1'
alias lsda2='eza -TDa --level 2'
alias lsda3='eza -TDa --level 3'
# list all items in tree format including hidden ones (or specify how many levels to list them)
alias lsta='eza -Ta'
alias lsta1='eza -Ta --level 1'
alias lsta2='eza -Ta --level 2'
alias lsta3='eza -Ta --level 3'

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
  alias cmd='compgen -c | fzf' # search for a possible command
  alias zh='history | fzf' # search in bash command history
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

### **Using `eza`**

:::tip What is `eza`?
`eza` is a modern alternative to the classic `ls`, it provides colour-coding, tree-styled outputs, git integration, and more.
:::

:::::steps

- **Installation**

  ::::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install eza
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  pacman -S eza
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  sudo apt install eza
  ```

  ::::

- **Add aliases**

  Below are some example aliases:
  :::code-tabs

  @tab .bashrc

  ```bash
  # list directories in a tree format (or specify how many levels to list them)
  alias lsd='eza -TD'
  alias lsd1='eza -TD --level 1'
  alias lsd2='eza -TD --level 2'
  alias lsd3='eza -TD --level 3'
  # list items in tree format (or specify how many levels to list them)
  alias lst='eza -T'
  alias lst1='eza -T --level 1'
  alias lst2='eza -T --level 2'
  alias lst3='eza -T --level 3'
  # list all directories in tree format including hidden ones (or specify how many levels to list them)
  alias lsda='eza -TDa'
  alias lsda1='eza -TDa --level 1'
  alias lsda2='eza -TDa --level 2'
  alias lsda3='eza -TDa --level 3'
  # list all items in tree format including hidden ones (or specify how many levels to list them)
  alias lsta='eza -Ta'
  alias lsta1='eza -Ta --level 1'
  alias lsta2='eza -Ta --level 2'
  alias lsta3='eza -Ta --level 3'
  ```

  :::

- **More resources**
  - [Quick overview](https://www.youtube.com/watch?v=mmqDYw9C30I&t=615s) on `eza` by Josean Martinez

:::::

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

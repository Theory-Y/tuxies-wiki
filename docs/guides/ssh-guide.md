---
title: SSH Guide
tags:
  - Beginner
  - Productivity
createTime: 2025/07/14 18:18:12
permalink: /guides/ssh-guide/
contributors:
  - joseporcar
---

:::tip Why use SSH
SSH is very useful if you wish to access your home computer when you are not at home. This can let you see the status of any program or run a new one. Doing so carefully is very important as in order to access it from beyond your home network special security measures must be enacted.
:::
:::info Prerequisites
This guide assumes you have OpenSSH installed, and Gnome
(or at least the Advanced Network Manager that comes with it on Debian)
:::

:::details Want a quick and dirty approach?
Just by installing OpenSSH on both machines, you should be able to access ssh from your tailscale machine via port 22 via:

```bash
ssh [server-username]@[server_ip] -p 22;
```

This should be safe enough if you use a service like [Tailscale](https://tailscale.com/), but the rest of the guide will add some security settings that will help secure the machine for other usages.
:::

::::steps

- **First time**

  On the client machine connected to the same network as the home computer you should run.

  ```bash
  ssh [server_username]@[server_ip] -p 22
  ```

  You will be prompted for a password, enter the one of your home machine
  :::tip How do I get those values exactly?
  You can get your username from running whoami on the home server, and the ip is the one you set up for static ip
  :::

- **Changing to more secure settings**

  Now, we are going to configure your home machine for more convenience and security. To do this run the following

  ```bash
  ssh-keygen -t ed25519 -f ~/.ssh/[name_for_keys]; # Creates the client keys
  ssh-copy-id -i ~/.ssh/[name_for_keys].pub [server_username]@[server_ip]
  ```

  After setting up this key we will change the settings of ssh in `/etc/ssh/sshd_config`. Here you are going to want to append the following lines

  ```
  PermitRootLogin no
  PasswordAuthentication no
  ```

  After this run the following for your changes to take effect

  ```bash
  sudo systemctl restart ssh
  ```

- **Setting up external security programs**

  Next up, you want to set up fail2ban to block anyone who tries to spam your ssh connection. This shouldn't really be necessary with Tailscale, but who knows maybe some day you accidentally open up the port, and this should protect you.

  ```bash
  sudo apt install fail2ban
  printf '[sshd]\nenabled = true\nbackend = systemd\n' | sudo tee /etc/fail2ban/jail.local
  sudo systemctl restart fail2ban
  ```

- **Accessing from beyond local**
  You should be able to access the server on your external machine by running the following. The server IP is best acquired via [Tailscale](https://tailscale.com/), but you can also open up port 22 in your router settings for a less secure approach:
  ```bash
  eval "$(ssh-agent)";
  ssh-add ~/.ssh/[name_for_keys]; # You defined the name a while back
  ssh [server-username]@[server_ip] -p 22;
  ```

::::

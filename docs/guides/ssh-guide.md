---
title: SSH Guide
tags:
  - Intermediate
  - Networking
  - Docker
createTime: 2025/07/14 18:18:12
permalink: /guides/ssh-guide/
contributors:
  - joseporcar
  - Lunear01
---

:::tip Why use SSH remotely
SSH lets you log into and control a computer from somewhere else, handy for checking on a home server while you're out. The old way of doing this meant opening a "door" (port 22) in your router so the internet could reach it directly, which also means anyone scanning the internet could find that door and try to break in. Both methods below let you connect from anywhere without exposing and port to the public internet.
:::

:::info Prerequisites
This guide assumes your home server already has an ==SSH server== running, with a static IP address and OpenSSH enabled (often installed by default on Linux). It also assumes you're using and familiar with Docker and Docker Compose. Only the Cloudflare Tunnel path needs you to own a domain (a web address like `example.com`); Tailscale needs neither a domain nor an open port.
:::

## **Harden SSH before exposing it**

::::steps

- **First-time login over the LAN**

  From a client on the same network:

  ```bash
  ssh [server_username]@[server_ip] -p 22
  ```

  Enter your account password when prompted.
  :::tip Where do these values come from?
  `whoami` on the server gives you `[server_username]`; `[server_ip]` is whatever static/reserved address you assigned it on your router.
  :::

- **Switch to key-based login**

  A password can be guessed; a key pair can't. This creates one (`ed25519` is just a modern, secure key type) and copies the public half to the server:

  ```bash
  ssh-keygen -t ed25519 -f ~/.ssh/[key_name]
  ssh-copy-id -i ~/.ssh/[key_name].pub [server_username]@[server_ip]
  ```

  Then, in the SSH server's config file, `/etc/ssh/sshd_config`, turn password logins off entirely by appending:

  ```
  PermitRootLogin no
  PasswordAuthentication no
  ```

  Restart the SSH server so the change takes effect (Debian/Ubuntu names the service `ssh`, everywhere else it's `sshd`):

  ```bash
  sudo systemctl restart sshd
  ```

  From here, `[server_ip]` only needs to stay reachable on your LAN — both methods below route to it without ever putting `22` on the internet.

::::

## Cloudflare Tunnel Vs. Tailscale

|                | Cloudflare Tunnel                                            | Tailscale                                             |
| -------------- | -------------------------------------------------------------- | -------------------------------------------------------- |
| Cost           | you need to own a domain, ~==15 USD a year==                   | free                                                      |
| Connection     | a private link your server opens out to Cloudflare              | a direct link between your devices, when possible         |
| If that fails  | still fast — Cloudflare's own network                            | a detour through a relay server — ==noticeably slower==   |
| Extra login    | yes, Cloudflare can ask for a login before letting anyone in      | no, just your SSH key                                     |

## **Cloudflare Tunnel**

:::tip How a tunnel works, in plain terms
A small program on your server, `cloudflared`, reaches *out* to Cloudflare and keeps that connection open — like your server calling Cloudflare instead of waiting for Cloudflare (or anyone else) to call it. Nobody can dial your server directly anymore. When you connect from your laptop, Cloudflare checks who you are, then relays you through the connection your server already opened.
:::

:::details Technical detail: what's actually happening
`cloudflared` opens outbound HTTP/2 or QUIC connections to Cloudflare's nearest edge location — no inbound port, no NAT rule, no port-forward. Your hostname's DNS record is a CNAME to `<tunnel-id>.cfargotunnel.com`, proxied through Cloudflare, so your home IP is never exposed. On connect, the edge terminates TLS (the encryption layer behind `https://`), optionally enforces an Access policy, then forwards the raw TCP stream through the tunnel to `cloudflared`, which hands it to `sshd`.
:::

::::steps

- **Get a domain onto Cloudflare**

  A tunnel needs an address like `ssh.example.com` to answer to, so you'll need to own a domain and add it to a free Cloudflare account (the account itself costs nothing). If you don't already have one, buying it straight through Cloudflare Registrar is the cheapest option: they sell domains at-cost, roughly ==15 USD a year== for a `.com`, with no markup on renewal.

- **Create the tunnel**

  In the [Zero Trust dashboard](https://one.dash.cloudflare.com/), go to `Networks` > `Tunnels` > `Create a tunnel`, pick `Cloudflared`, and name it (e.g. `home-ssh`). Copy the connector token it gives you — that's your `TUNNEL_TOKEN`.

- **Run `cloudflared` as a container**

  :::code-tabs

  @tab docker-compose.yml

  ```yaml
  services:
    cloudflared:
      image: cloudflare/cloudflared:latest
      restart: unless-stopped
      command: tunnel run
      environment:
        - TUNNEL_TOKEN=${TUNNEL_TOKEN}
      networks:
        - ssh-net

  networks:
    ssh-net:
      external: true
  ```

  :::

  Put whatever is running your SSH server on the same `ssh-net` network so `cloudflared` can reach it by service name. `cloudflared` makes only outbound connections, so it needs no published ports of its own.

- **Map the hostname to your SSH server**

  Under the tunnel's `Public Hostname` tab, add one: your subdomain and zone, `Service` type `SSH`, `URL` pointing at the container on the docker network, e.g. `ssh-server:22`.

- **Add a login screen with Access**

  Cloudflare Access lets you put a login page in front of the tunnel — for example, requiring a one-time code sent to your email before anyone gets through. Add an Access application for your hostname to turn this on. It's an extra check that happens before Cloudflare even relays the connection to your server, so a leaked SSH key alone still wouldn't be enough to get in.

- **Connect from your client**

  Install the `cloudflared` client:

  :::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install -y https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-x86_64.rpm
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  curl -Lo cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
  sudo dpkg -i cloudflared.deb
  ```

  @tab ::devicon:archlinux:: Arch (AUR)

  ```bash
  yay -S cloudflared-bin
  ```

  :::

  Then either run it inline:

  ```bash
  cloudflared access ssh --hostname ssh.example.com
  ```

  or wire it into your SSH config so plain `ssh` works:

  :::code-tabs

  @tab ~/.ssh/config

  ```
  Host ssh.example.com
    ProxyCommand cloudflared access ssh --hostname %h
  ```

  :::

::::

:::details Why this beats port-forwarding
Forwarding `22` puts `sshd` directly on the public internet — scanners find it within hours, and every packet reaching it has already forced your firewall and `sshd` to negotiate a handshake, key auth or not. A tunnel flips that: your server makes the only connection, outbound, to an address it already trusts. There's no listening socket for an attacker to reach without first clearing Cloudflare's edge and, if configured, an Access policy — `sshd` never sees a packet from anyone who hasn't passed both.
:::

## **Tailscale (Free Alternative)**

:::tip How it works, in plain terms
Tailscale creates a private network (a "tailnet") between just your own devices. Install it on two devices and log into the same account, and they can reach each other by a friendly name, as if they were on the same LAN — no matter where either one actually is.
:::

:::details Technical detail: what's actually happening
Tailscale builds a mesh VPN over WireGuard (a fast, modern VPN protocol). Each device gets a stable `100.x.y.z` tailnet address and a MagicDNS name, and devices try to negotiate a direct peer-to-peer link through NAT (the address-sharing your router does for your home network) using a lightweight coordination server first.
:::

::::steps

- **Run it as a Docker sidecar**

  :::code-tabs

  @tab docker-compose.yml

  ```yaml
  services:
    tailscale:
      image: tailscale/tailscale:latest
      hostname: home-ssh
      environment:
        - TS_AUTHKEY=${TS_AUTHKEY}
        - TS_STATE_DIR=/var/lib/tailscale
      volumes:
        - ts-state:/var/lib/tailscale
      devices:
        - /dev/net/tun:/dev/net/tun
      cap_add:
        - NET_ADMIN
      restart: unless-stopped

  volumes:
    ts-state:
  ```

  :::

  Generate `TS_AUTHKEY` from the [Tailscale admin console](https://login.tailscale.com/admin/settings/keys). Other containers on the box can share this identity with `network_mode: service:tailscale`; the sidecar itself only needs to exist to authenticate the machine onto your tailnet.

- **Connect**

  ```bash
  ssh [server_username]@home-ssh
  ```

  MagicDNS resolves `home-ssh` to the tailnet address — no port-forward, domain, or public DNS record involved.

::::

:::warning The fallback path is slow
A direct link between your devices isn't always possible — some home and mobile networks are set up in ways that block it. When that happens, Tailscale falls back to bouncing your traffic through one of its own relay servers instead. That detour is shared with other users and noticeably slower than a direct link or a Cloudflare Tunnel. Run `tailscale status` and check for the word `relay` next to a device to see whether you've landed on this slower path.
:::

---
title: QEMU/KVM Guide
tags:
  - Virtualisation
  - Archived
createTime: 2025/06/25 09:05:08
permalink: /archived/qemu-kvm-guide/
---

:::warning Under construction
:::

## **What is QEMU/KVM?**

In essence, QEMU/KVM are used to achieve virtual machines (VM) on Linux with high performanace through GPU acceleration. It offers more customibility and performance comparing with other existing VM softwares such as [GNOME Boxes](https://apps.gnome.org/Boxes/) and [VMware](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion).

QEMU stands for ==Quick Emulator==, it's the main virtualisation software that allows full-system emulation. KVM stands for ==Kernel-based Virtual Machine==, it's a Linux kernel module that allows VM to run efficiently at kernel level.

## Setting Up QEMU/KVM

::::steps

- Installation
  ::::tabs

  @tab Fedora

  ```bash
  sudo dnf install @virtualization
  sudo systemctl enable --now libvirtd
  sudo usermod -aG libvirt $(whoami)
  newgrp libvirt  # Apply group changes without logout
  ```

  @tab Arch

  ```bash
  sudo pacman -S qemu libvirt virt-manager dnsmasq ebtables iptables
  ```

  @tab Debian/Ubuntu

  ```bash
  sudo apt update
  sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

  # Add your user to the necessary groups
  sudo usermod -aG kvm $(whoami)
  sudo usermod -aG libvirt $(whoami)
  newgrp libvirt  # Apply group changes without logout

  sudo systemctl enable --now libvirtd
  ```

  ::::

::::

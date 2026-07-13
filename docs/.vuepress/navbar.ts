/**
 * @see https://theme-plume.vuejs.press/config/navigation/ 查看文档了解配置详情
 *
 * Navbar 配置文件，它在 `.vuepress/plume.config.ts` 中被导入。
 */

import { defineNavbarConfig } from "vuepress-theme-plume";

export const enNavbar = defineNavbarConfig([
  {
    text: "Introduction",
    icon: "mdi:hand-wave",
    items: [
      {
        text: "Get Started",
        icon: "mdi:compass",
        link: "/introduction/new-to-the-wiki/",
      },
      {
        text: "Linux Vocabs",
        icon: "mdi:book-alphabet",
        link: "/introduction/linux-vocabs/",
      },
      {
        text: "Flatpak Setup",
        icon: "mdi:cog",
        link: "/introduction/flatpak-setup/",
      },
    ],
  },
  {
    text: "Linux Guides",
    icon: "mdi:school",
    items: [
      {
        text: "Get Started",
        icon: "mdi:compass",
        link: "/linux-guides/",
      },
      {
        text: "Flashing Guide",
        icon: "mdi:usb-flash-drive",
        link: "/linux-guides/flashing-guide/",
      },
      {
        text: "Distro Guides",
        items: [
          {
            text: "Fedora",
            icon: "mdi:fedora",
            link: "/linux-guides/fedora/",
          },
          {
            text: "Arch",
            icon: "mdi:arch",
            link: "linux-guides/arch/",
          },
          {
            text: "Debian",
            icon: "mdi:debian",
            link: "linux-guides/debian/",
          },
        ],
      },
      {
        text: "Desktop Env. Guides",
        items: [
          {
            text: "Gnome",
            icon: "mdi:gnome",
            link: "linux-guides/gnome/",
          },
        ],
      },
    ],
  },
  {
    text: "Apps Library",
    icon: "mdi:bookshelf",
    items: [
      {
        text: "Get Started",
        icon: "mdi:compass",
        link: "/linux-apps/",
      },
      {
        text: "Editor's Choice",
        icon: "material-symbols:editor-choice-rounded",
        link: "/linux-apps/editors-choice/",
      },
      {
        text: "Essentials",
        icon: "material-symbols:label-important-rounded",
        link: "/linux-apps/essentials/",
      },
      {
        text: "Creative Software",
        icon: "mdi:head-thinking",
        link: "/linux-apps/creative-software/",
      },
      {
        text: "Dev (Computer Nerd) Tools",
        icon: "mdi:console",
        link: "/linux-apps/dev-tools/",
      },
    ],
  },
  {
    text: "Other Guides",
    icon: "mdi:newspaper-variant",
    link: "/guides/",
  },
  // {
  //   text: "Sort",
  //   icon: "mdi:sort",
  //   link: "/blog/tags/",
  // },
  {
    text: "About",
    icon: "mdi:about",
    items: [
      {
        text: "About Us",
        icon: "mdi:about-variant",
        link: "/about/",
      },
      {
        text: "Our Team",
        icon: "mdi:people-group",
        link: "/about/our-team/",
      },
      {
        text: "Contributions",
        items: [
          {
            text: "Become a Contributor",
            icon: "mdi:pencil-plus",
            link: "/contributions/",
          },
          {
            text: "Dev Setup Guide",
            icon: "mdi:dev-to",
            link: "/contributions/dev-setup-guide/",
          },
          {
            text: "Contribution Guidelines",
            icon: "mdi:script",
            link: "/contributions/guidelines/",
          },
        ],
      },
    ],
  },
]);

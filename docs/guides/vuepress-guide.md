---
title: Vuepress Guide
tags:
  - Advanced
  - Wiki
  - Web Dev
createTime: 2025/06/08 01:20:38
permalink: /guides/vuepress-guide/
contributors:
  - Lunear
  - aier
---

<!-- end of card grid -->

:::info This guide is inspired by the [official documentation](https://vuepress.vuejs.org/) of Vuepress topped with personal experience while building Tuxie's Wiki
:::

:::card title="What is Vuepress?" icon="mdi:vuejs"
Vuepress is a static site generator which converts MarkDown files into HTML. It offers a good option for one who desires to create their personal blog, documentation, or website. Vuepress offers high customisation as it permits CSS from the user, yet it keeps everything simple out of the box.
:::

## **Installation**

- Prerequisite: [Install Node.js](https://nodejs.org/en)
  :::note
  There are many community-based themes with many built functionalities. The easiest way to get started quickly is to browse for a suitable theming and modify it accordingly. For example, this website is built upon [plume theme](https://theme-plume.vuejs.press/en/).
  :::

## **Folder Structure**

:::important
Below is a sample folder structure and its file formatting, this may vary depending on the theme being used
:::

:::code-tree title="Folder Structure" height="700px" entry="docs/README.md"

```yaml title=".github(For Github Deployment)/workflows/deploy.yml"
name: deploy
on:
  # Trigger deployment whenever a push is made to the main branch
  # push:
  #   branches: [main]
  # Manually trigger deployment
  workflow_dispatch:
jobs:
  docs:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
        with:
          # To fetch all commit history for "Last updated time" and other git log information
          fetch-depth: 0

      - name: Setup pnpm
        uses: pnpm/action-setup@v4
        with:
          # Choose the pnpm version to use
          version: 8
          # Install dependencies using pnpm
          run_install: true

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          # Choose the node version to use
          node-version: 20
          # Cache pnpm dependencies
          cache: pnpm

      # Run the build script
      - name: Build VuePress site
        run: pnpm docs:build

      # See the workflow documentation for more information
      # @see https://github.com/crazy-max/ghaction-github-pages
      - name: Deploy to GitHub Pages
        uses: crazy-max/ghaction-github-pages@v4
        with:
          # Deploy to the gh-pages branch
          target_branch: gh-pages
          build_dir: docs/.vuepress/dist
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

```js title="docs/.vuepress/config.js"
import { defineUserConfig } from "vuepress";
import { defaultTheme } from "@vuepress/theme-default";
import { searchPlugin } from "@vuepress/plugin-search";
import { googleAnalyticsPlugin } from "@vuepress/plugin-google-analytics";

export default defineUserConfig({
  // ========== Basic Config ==========
  lang: "en-US",
  title: "Your Site Title",
  description: "Your site description",

  // ========== Deployment Config ==========
  base: process.env.NODE_ENV === "production" ? "/repository-name/" : "/",

  // ========== Theme Config ==========
  theme: defaultTheme({
    logo: "/images/logo.png",
    navbar: [
      { text: "Home", link: "/" },
      { text: "Guide", link: "/guide/" },
      { text: "GitHub", link: "https://github.com/your-repo" },
    ],
    sidebar: {
      "/guide/": [
        {
          text: "Guide",
          children: ["/guide/README.md", "/guide/getting-started.md"],
        },
      ],
    },
    repo: "your-username/your-repo",
    docsBranch: "main",
    editLinkText: "Edit this page on GitHub",
    lastUpdated: true,
    contributors: true,
  }),

  // ========== Plugins ==========
  plugins: [
    searchPlugin({
      maxSuggestions: 10,
      hotKeys: ["s", "/"],
    }),
    googleAnalyticsPlugin({
      id: "G-XXXXXXXXXX", // Your GA tracking ID
    }),
    // Add other plugins here
  ],

  // ========== Head Tags ==========
  head: [
    ["meta", { name: "theme-color", content: "#3eaf7c" }],
    ["meta", { name: "apple-mobile-web-app-capable", content: "yes" }],
    [
      "meta",
      { name: "apple-mobile-web-app-status-bar-style", content: "black" },
    ],
    ["link", { rel: "icon", href: "/favicon.ico" }],
    // Add other head tags here
  ],

  // ========== Markdown Extensions ==========
  markdown: {
    code: {
      lineNumbers: true,
    },
    // Enable custom containers
    extractHeaders: ["h2", "h3", "h4"],
  },
});
```

```md title="docs/.vuepress/public/"
This is the folder where you put all the static assets (images, fonts)
```

```vue title="docs/.vuepress/theme(optional)/components/custom.vue"
<script setup lang="ts">
import { ref } from "vue";

const message = ref("Hello World!");
</script>

<template>
  <div class="my-custom-content">
    {{ message }}
  </div>
</template>
```

```md title="docs/.vuepress/theme(optional)/styles/custom.css"
:root {
--vp-home-hero-name-color: transparent;
--vp-home-hero-name-background: linear-gradient(
120deg,
var(--vp-c-purple-1) 30%,
var(--vp-c-brand-2)
);
--vp-home-hero-tagline: var(--vp-c-text-2);
--vp-home-hero-text: var(--vp-c-text-1);
--vp-home-hero-image-background-image: linear-gradient(
-45deg,
var(--vp-c-brand-soft) 50%,
var(--vp-c-brand-2) 50%
);
--vp-home-hero-image-filter: blur(44px);
}

.hero-tagline {
line-height: 1; /_ Adjust spacing _/
}
```

```md title="docs/guides/guide1.md"
---
tags:
  - Some tag
title: My name is Lunear
createTime: 2025/05/22 09:05:08
permalink: /guides/some-name
---
```

```md title="docs/guides/guide2.md"
---
tags:
  - Some tag
title: My name is Lunear
createTime: 2025/05/22 09:05:08
permalink: /guides/some-name
---
```

```md title="docs/blogs/blog1.md"
---
title: "Page Title"
author: "Page Author"
createTime: 2025/05/22 09:05:08
permalink: /your/directory/goes/here
---
```

```md title="docs/blogs/blog2.md"
---
title: "Page Title"
author: "Page Author"
createTime: 2025/05/22 09:05:08
permalink: /your/directory/goes/here
---
```

```json title="package.json"
{
  "name": "Name of the website",
  "type": "module",
  "version": "Vuepress version",
  "description": "Description of the website",
  "license": "MIT",
  "engines": {
    "node": "^20.6.0 || >=22.0.0"
  },
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs --clean-cache --clean-temp",
    "deploy": "npm run build && gh workflow run deploy"
  },
  "devDependencies": {
    "@vuepress/bundler-vite": "^2.0.0-rc.23",
    "http-server": "^14.1.1",
    "sass-embedded": "^1.89.0",
    "typescript": "^5.8.3",
    "vue": "^3.5.14",
    "vuepress": "2.0.0-rc.23",
    "vuepress-theme-plume": "1.0.0-rc.152"
  }
}
```

```md title="docs/README.md"
---
home: true
heroImage: /images/logo.png
heroAlt: Project logo
heroText: Your Project Name
tagline: Short punchy description (under 10 words)
actions:
  - text: Get Started →
    link: /guide/
    type: primary
  - text: View on GitHub
    link: https://github.com/your/repo
    type: secondary
features:
  - title: Feature 1
    details: Clear benefit statement (keep it short)
  - title: Feature 2
    details: Another compelling reason to use this
  - title: Feature 3
    details: Final key differentiator
footer: MIT Licensed | Copyright © 2023-Present Your Name
---

<!-- Optional additional content below the fold -->

## Quick Start `bash npm install your-package `
```

````md title="README.md"
This page is the README file for Github

# Tuxie's Wiki

The Site is generated using [vuepress](https://vuepress.vuejs.org/) and [vuepress-theme-plume](https://github.com/pengzhanbo/vuepress-theme-plume)

## Install

```sh
npm install
```

## Usage

```sh
# Start development environment
"dev": "vuepress dev docs",
"start": "vuepress dev docs",
# Start clean development environment
"dev-clean": "vuepress dev docs --clean-cache --clean-temp",
# Build website
"build": "vuepress build docs --clean-cache --clean-temp",
# Preview build
"preview": "http-server docs/.vuepress/dist",
# Vuepress update
"vp-update": "npx vp-update",
# Deploy website to GH Pages
"deploy": "npm run build && gh workflow run deploy",
# List deployments
"deploy-list": "gh run list --workflow=deploy.yml"
```

## TODO

- [ ] Team logo
- [x] Article: Guidelines
- [ ] Article: Gnome guide
- [ ] Article: New to the Wiki?
- [ ] Article: Set up Flatpak
- [ ] Set up Discord server
- [ ] Article: Linux vocabularies
- [ ] Test and publish
````

:::

## **Basic NPM Commands**

:::info
These commands are the default commands within the package.json file. You can manually add/delete commands to fit your own needs
:::

```bash
npm run docs:dev # Run the temporary development server
npm run docs:build # Build the website
```

## **Deployment**

:::info
There are many choices for web deployment, Github Pages will be used in this guide as it's free and facilitates collaboration
:::

:::info Two Options

1. Using `gh-pages` (Recommended for its stability)
2. Using `gh` and workflow for compiling and push/deploy the pages

:::

### **Option 1: (Recommended): Using `gh-pages`**

::::steps

- Install `gh-pages`
  ```bash
  npm install gh-pages
  ```
- Edit package.json to add a new command
  :::code-tabs

  @tab package.json

  ```json
  // Code omitted above...
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:dev-clean": "vuepress dev docs --clean-cache --clean-temp",
    "docs:build": "vuepress build docs --clean-cache --clean-temp",
    "docs:preview": "http-server docs/.vuepress/dist",
    "docs:vp-update": "npx vp-update",
    // [!code ++] [!code focus]
    "deploy": "npm run build &&  gh-pages -d directory/of/your/build/files -b gh-pages",
  },
  // Code omitted below...

  ```

  :::
  ::::

### **Option 2 Using `gh`**

::::::steps

- Install `gh` or `github-cli` from the official repository
  ::::tabs

  @tab ::devicon:fedora:: Fedora

  ```bash
  sudo dnf install gh
  ```

  @tab ::devicon:archlinux:: Arch

  ```bash
  sudo pacman -S github-cli
  ```

  @tab ::devicon:debian:: Debian/Ubuntu

  ```bash
  # Add GitHub's GPG key
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

  # Add the GitHub CLI repository
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

  # Update and install
  sudo apt update
  sudo apt install gh
  ```

  ::::

- Login/authenticate

  ```bash
  gh auth login
  ```

- Create/Push to Github repo

  :::tabs

  @tab Create Repo

  ```bash
  git init
  git add .
  git commit -m "Initial commit"
  gh repo create --public --push --source=.  # Creates repo and pushes code
  ```

  @tab Push to Repo

  ```bash
  git remote add origin https://github.com/<username>/<repo>.git
  git push -u origin main
  ```

  :::

  :::important Create `.github/workflow/deploy.yml`
  :::

- Edit `deploy.yml`

  ::::details See code...

  :::code-tabs

  @tab deploy.yml

  ```yml
  name: deploy

  on:
    # Trigger deployment whenever a push is made to the main branch
    # push:
    #   branches: [main]
    # Manually trigger deployment
    workflow_dispatch:

  jobs:
    docs:
      runs-on: ubuntu-latest

      steps:
        - uses: actions/checkout@v4
          with:
            # To fetch all commit history for "Last updated time" and other git log information
            fetch-depth: 0

        - name: Setup pnpm
          uses: pnpm/action-setup@v4
          with:
            # Choose the pnpm version to use
            version: 8
            # Install dependencies using pnpm
            run_install: true

        - name: Setup Node.js
          uses: actions/setup-node@v4
          with:
            # Choose the node version to use
            node-version: 20
            # Cache pnpm dependencies
            cache: pnpm

        # Run the build script
        - name: Build VuePress site
          run: pnpm docs:build

        # See the workflow documentation for more information
        # @see https://github.com/crazy-max/ghaction-github-pages
        - name: Deploy to GitHub Pages
          uses: crazy-max/ghaction-github-pages@v4
          with:
            # Deploy to the gh-pages branch
            target_branch: gh-pages
            build_dir: docs/.vuepress/dist
          env:
            GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  ```

  ::::

- Edit `package.json` to add a new command

  :::code-tabs

  @tab package.json

  ```json
  // Code omitted above...
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:dev-clean": "vuepress dev docs --clean-cache --clean-temp",
    "docs:build": "vuepress build docs --clean-cache --clean-temp",
    "docs:preview": "http-server docs/.vuepress/dist",
    "docs:vp-update": "npx vp-update",
    // [!code ++] [!code focus]
    "deploy": "npm run build && gh workflow run deploy",
  },
  // Code omitted below...

  ```

      :::

  ::::
  ::::::

:::card title="Done!" icon="fluent-emoji:party-popper"
Now, your Github page will have two branches, the `main` branch with all the `.md` files and the `gh-pages` with the Vuepress compiled `.html` files.

To deploy the website, simply run

```bash
npm run deploy
```

:::

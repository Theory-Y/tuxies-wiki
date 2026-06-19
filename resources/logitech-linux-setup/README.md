# logitech-linux-setup

Portable dotfiles and installer for the Logitech Linux setup described in the
[Logitech Linux Setup guide](../../docs/guides/logitech-linux-setup.md).
The guide covers replicating Logi Options+ key reassignment via Solaar and the
Actions Ring via Kando on Linux. This folder is the download bundle it references.

## Directory structure

```
logitech-linux-setup/
├── install.sh                      # Installer script — copies presets to the right config dirs
├── solaar/
│   └── rules.yaml                  # Solaar button-remap preset (portable rules only)
└── kando/
    ├── general-settings-backup.json  # Kando general settings  -> config.json
    └── menu-settings-backup.json     # Kando menu definitions  -> menus.json
```

## Files

| File | Installs to | Notes |
|---|---|---|
| `solaar/rules.yaml` | `<config>/solaar/rules.yaml` | Button-remap rules. Device-specific settings (DPI, backlight, haptic, smart-shift) are **not** portable and must be set in the Solaar GUI after pairing. |
| `kando/general-settings-backup.json` | `<config>/kando/config.json` | General Kando settings. |
| `kando/menu-settings-backup.json` | `<config>/kando/menus.json` | Kando menu definitions (the Actions Ring layout). |

Config paths per install type:

| App | Native | Flatpak |
|---|---|---|
| Solaar | `${XDG_CONFIG_HOME:-~/.config}/solaar/` | `~/.var/app/io.github.pwr_solaar.solaar/config/solaar/` |
| Kando | `${XDG_CONFIG_HOME:-~/.config}/kando/` | `~/.var/app/menu.kando.Kando/config/kando/` |

## Usage

```bash
./install.sh [--flatpak | --native] [-y | --yes] [-h | --help]
```

The script auto-detects whether each app is a Flatpak or native install and
copies the presets to the correct config directory. If both are present it
prefers Flatpak and warns you; use `--flatpak` or `--native` to override.

**Common invocations**

```bash
# Auto-detect install type (prompts only if Solaar is running)
./install.sh

# Auto-detect, no prompts
./install.sh -y

# Force Flatpak paths for both apps
./install.sh --flatpak -y

# Force native paths for both apps
./install.sh --native
```

**Flags**

| Flag | Description |
|---|---|
| `--flatpak` | Force Flatpak config paths for both apps. |
| `--native` | Force native (`$XDG_CONFIG_HOME`) config paths for both apps. |
| `-y`, `--yes` | Non-interactive: skip confirmation prompts. |
| `-h`, `--help` | Print usage and exit. |

## Behaviour notes

- **Idempotent.** Files that are byte-identical to what is already installed are
  silently skipped — re-running is safe.
- **Backups.** Any existing file that would be overwritten is backed up first as
  `<original>.bak.<YYYYMMDD-HHMMSS>` next to the original.
- **Solaar must be closed before running.** Solaar reads `rules.yaml` at
  startup and rewrites it when you edit rules in its GUI. Installing while it is
  running risks having your changes overwritten. The script detects this and
  warns you; it will ask you to confirm before continuing.
- **Kando hot-reloads.** Kando watches its config files and picks up changes
  immediately — you do not need to close it first.
- **Device-specific Solaar options are not included.** DPI, backlight level,
  haptic feedback, smart-shift, and scroll-ratchet settings are per physical
  device. Set them in the Solaar GUI after pairing your device.

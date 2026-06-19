#!/usr/bin/env bash
#
# install.sh — quick-install the Solaar + Kando dotfiles in this folder.
#
# Copies the portable presets shipped alongside this script into the right
# config directories, auto-detecting whether each app is a Flatpak or a native
# install. Existing files are backed up (timestamped) before being replaced.
#
#   Solaar   rules.yaml                  -> <config>/solaar/rules.yaml
#   Kando    general-settings-backup.json-> <config>/kando/config.json
#   Kando    menu-settings-backup.json   -> <config>/kando/menus.json
#
# Usage:
#   ./install.sh [--flatpak | --native] [-y|--yes] [-h|--help]
#
#   --flatpak   Force the Flatpak config paths (~/.var/app/<id>/config/...).
#   --native    Force the native config paths   (${XDG_CONFIG_HOME:-~/.config}).
#   -y, --yes   Non-interactive: don't prompt, assume yes.
#   -h, --help  Show this help and exit.
#
# Only the *portable* parts are installed. Device-specific Solaar settings (DPI,
# backlight, haptic level, smart-shift, scroll ratchet, ...) live per physical
# device and must be set in the Solaar GUI after pairing — they are not exported.

set -euo pipefail

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"

SOLAAR_ID="io.github.pwr_solaar.solaar"
KANDO_ID="menu.kando.Kando"

FORCE_MODE="auto"   # auto | flatpak | native
ASSUME_YES=false

# ---------------------------------------------------------------------------
# Pretty output (colour only on a TTY)
# ---------------------------------------------------------------------------
if [ -t 1 ]; then
  C_RESET=$'\033[0m'; C_BLUE=$'\033[34m'; C_GREEN=$'\033[32m'
  C_YELLOW=$'\033[33m'; C_RED=$'\033[31m'; C_BOLD=$'\033[1m'
else
  C_RESET=''; C_BLUE=''; C_GREEN=''; C_YELLOW=''; C_RED=''; C_BOLD=''
fi
info() { printf '%s==>%s %s\n' "$C_BLUE"   "$C_RESET" "$*"; }
ok()   { printf '%s ok%s %s\n' "$C_GREEN"  "$C_RESET" "$*"; }
warn() { printf '%s  !%s %s\n' "$C_YELLOW" "$C_RESET" "$*" >&2; }
die()  { printf '%serror%s %s\n' "$C_RED"  "$C_RESET" "$*" >&2; exit 1; }

# Print the leading comment block (minus the shebang) as help text.
usage() { awk 'NR==1{next} /^#/{sub(/^# ?/,""); print; next} {exit}' "$0"; exit "${1:-0}"; }

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
while [ $# -gt 0 ]; do
  case "$1" in
    --flatpak) FORCE_MODE="flatpak" ;;
    --native)  FORCE_MODE="native" ;;
    -y|--yes)  ASSUME_YES=true ;;
    -h|--help) usage 0 ;;
    *) die "unknown option: $1 (try --help)" ;;
  esac
  shift
done

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# pick_mode <flatpak-installed?> : prints "flatpak" or "native".
# Respects --flatpak/--native; otherwise prefers Flatpak when present.
pick_mode() {
  local fp="$1"
  case "$FORCE_MODE" in
    flatpak) echo flatpak; return ;;
    native)  echo native;  return ;;
  esac
  if "$fp"; then echo flatpak; else echo native; fi
}

# install_file <src> <dest>: back up an existing dest, then copy src over it.
install_file() {
  local src="$1" dest="$2"
  [ -f "$src" ] || die "missing source file: $src (run this script from inside the logitech-linux-setup folder)"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ]; then
    if cmp -s "$src" "$dest"; then
      ok "unchanged: $dest"
      return
    fi
    local backup="$dest.bak.$STAMP"
    cp -p "$dest" "$backup"
    warn "backed up existing $(basename "$dest") -> $backup"
  fi
  cp "$src" "$dest"
  ok "installed: $dest"
}

confirm() {
  # $1 = prompt. Returns 0 to proceed.
  "$ASSUME_YES" && return 0
  [ -t 0 ] || return 0   # non-interactive without -y: proceed (backups protect us)
  local reply
  printf '%s [y/N] ' "$1" >&2
  read -r reply || true
  [[ "$reply" =~ ^[Yy]$ ]]
}

# ---------------------------------------------------------------------------
# Solaar
# ---------------------------------------------------------------------------
install_solaar() {
  local fp=false nat=false mode dir
  flatpak info "$SOLAAR_ID" >/dev/null 2>&1 && fp=true
  command -v solaar >/dev/null 2>&1 && nat=true
  mode="$(pick_mode "$fp")"

  if "$fp" && "$nat"; then
    warn "Solaar detected as both Flatpak and native; using $mode (override with --flatpak/--native)."
  elif ! "$fp" && ! "$nat" && [ "$FORCE_MODE" = auto ]; then
    warn "No Solaar install detected; staging config at the native path for first launch."
  fi

  if [ "$mode" = flatpak ]; then
    dir="$HOME/.var/app/$SOLAAR_ID/config/solaar"
  else
    dir="$CONFIG_HOME/solaar"
  fi

  info "Solaar ($mode) -> $dir"

  # Solaar reads rules.yaml at startup and rewrites it when you edit rules in
  # its GUI — if it's running it can clobber what we install. Recommend quitting.
  if pgrep -fi 'solaar' >/dev/null 2>&1; then
    warn "Solaar appears to be running. Quit it before installing so it loads the new rules on next launch and doesn't overwrite them."
    confirm "Continue anyway?" || die "aborted by user — quit Solaar and re-run."
  fi

  install_file "$SCRIPT_DIR/solaar/rules.yaml" "$dir/rules.yaml"
}

# ---------------------------------------------------------------------------
# Kando
# ---------------------------------------------------------------------------
install_kando() {
  local fp=false nat=false mode dir
  flatpak info "$KANDO_ID" >/dev/null 2>&1 && fp=true
  command -v kando >/dev/null 2>&1 && nat=true
  mode="$(pick_mode "$fp")"

  if "$fp" && "$nat"; then
    warn "Kando detected as both Flatpak and native; using $mode (override with --flatpak/--native)."
  elif ! "$fp" && ! "$nat" && [ "$FORCE_MODE" = auto ]; then
    warn "No Kando install detected; staging config at the native path for first launch."
  fi

  if [ "$mode" = flatpak ]; then
    dir="$HOME/.var/app/$KANDO_ID/config/kando"
  else
    dir="$CONFIG_HOME/kando"
  fi

  info "Kando ($mode) -> $dir"
  # Kando hot-reloads its config files on save, so replacing them while it runs
  # is safe — no need to quit it first.
  install_file "$SCRIPT_DIR/kando/general-settings-backup.json" "$dir/config.json"
  install_file "$SCRIPT_DIR/kando/menu-settings-backup.json"    "$dir/menus.json"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
printf '%sLogitech Linux setup — Solaar + Kando dotfiles%s\n\n' "$C_BOLD" "$C_RESET"

install_solaar
echo
install_kando

cat <<EOF

${C_GREEN}${C_BOLD}Done.${C_RESET} Next steps:
  • ${C_BOLD}Solaar${C_RESET}: (re)start it so the new rules load. Pair your device, then set
    device-specific options (DPI, backlight, haptic, smart-shift) in the GUI —
    those are per-device and are not part of rules.yaml.
  • ${C_BOLD}Kando${C_RESET}: it hot-reloads, so your menus and settings are already live. If
    not, restart Kando. Remember it must autostart at login to be available.

Backups of any replaced files were saved next to them as *.bak.${STAMP}.
EOF

#!/usr/bin/env bash
#
# install.sh — highly interactive installer for the Solaar + Kando dotfiles.
#
# Shows you exactly what will be written, lets you edit each file in your
# $EDITOR before it lands, and optionally fixes the Wayland uinput permission
# issue so remapped buttons fire keystrokes.
#
#   Solaar   solaar/rules.yaml               -> <config>/solaar/rules.yaml
#   Kando    kando/general-settings-backup.json -> <config>/kando/config.json
#   Kando    kando/menu-settings-backup.json    -> <config>/kando/menus.json
#
# Usage:
#   ./install.sh [--flatpak | --native] [-y|--yes] [-h|--help]
#
#   --flatpak   Force the Flatpak config paths (~/.var/app/<id>/config/...).
#   --native    Force the native config paths   (${XDG_CONFIG_HOME:-~/.config}).
#   -y, --yes   Non-interactive: skip confirmation prompts; no editor is launched
#               and the uinput phase is skipped (it requires interactive consent).
#   -h, --help  Show this help and exit.
#
# Only the *portable* parts are installed. Device-specific Solaar settings (DPI,
# backlight, haptic level, smart-shift, scroll ratchet, ...) live per physical
# device and must be set in the Solaar GUI after pairing — they are not exported.

set -euo pipefail

###############
### Colours ###
###############

INFO=$'\033[0;34m'          # General announcements, headers  (blue)
EMPH=$'\033[1;34m'          # Section titles, key info        (bold blue)
PROMPT=$'\033[1;36m'        # User-facing prompts             (bold cyan)
SUCCESS=$'\033[1;32m'       # Success, confirmation           (bold green)
WARNING=$'\033[1;33m'       # Warnings, caution               (bold yellow)
ERROR=$'\033[1;31m'         # Errors, cancellations           (bold red)
DIM=$'\033[0;90m'           # Secondary / passive text        (grey)
NC=$'\033[0m'               # Reset

###############################
### Constants & arg parsing ###
###############################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"

SOLAAR_ID="io.github.pwr_solaar.solaar"
KANDO_ID="menu.kando.Kando"
EDITOR_NAME="$(basename "${EDITOR:-nano}")"

FORCE_MODE="auto"   # auto | flatpak | native
ASSUME_YES=false

# Print the leading comment block (minus the shebang) as help text.
usage() { awk 'NR==1{next} /^#/{sub(/^# ?/,""); print; next} {exit}' "$0"; exit "${1:-0}"; }

while [ $# -gt 0 ]; do
    case "$1" in
        --flatpak) FORCE_MODE="flatpak" ;;
        --native)  FORCE_MODE="native"  ;;
        -y|--yes)  ASSUME_YES=true      ;;
        -h|--help) usage 0              ;;
        *) echo -e "${ERROR}Unknown option: $1 (try --help)${NC}" >&2; exit 1 ;;
    esac
    shift
done

################################
### Temp directory & cleanup ###
################################

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

##########################
### Reusable functions ###
##########################

# ask <label>
#   Prints a [y/n] gate.  Returns 0 to proceed, 1 to skip.
#   Never calls exit — callers decide what to do on "n".
#   Under -y/--yes, always returns 0 (proceed).
ask() {
    local label="${1:-proceed}"
    if "$ASSUME_YES"; then
        return 0
    fi
    while true; do
        read -p "${PROMPT}Do you want to ${label}? [y/n]: ${NC}" yn
        case $yn in
            [yY] ) echo -e "${SUCCESS}\nProceeding...\n${NC}"; return 0 ;;
            [nN] ) echo -e "${ERROR}\nSkipping.\n${NC}"; return 1 ;;
            *    ) echo -e "${WARNING}\nPlease enter y or n.\n${NC}" ;;
        esac
    done
}

# ask_edit
#   Offers to open a file in $EDITOR.  Returns 0 to edit, 1 to skip.
#   Under -y/--yes or a non-interactive TTY, always returns 1 (no edit).
ask_edit() {
    if "$ASSUME_YES" || [ ! -t 0 ]; then
        return 1
    fi
    while true; do
        read -p "${PROMPT}Use ${EDITOR_NAME} to customise before installing? [y/n]: ${NC}" yn
        case $yn in
            [yY] ) return 0 ;;
            [nN] ) return 1 ;;
            *    ) echo -e "${WARNING}\nPlease enter y or n.\n${NC}" ;;
        esac
    done
}

# pick_mode <fp_bool>
#   Prints "flatpak" or "native". Respects --flatpak/--native; otherwise
#   prefers Flatpak when present.
pick_mode() {
    local fp="$1"
    case "$FORCE_MODE" in
        flatpak) echo flatpak; return ;;
        native)  echo native;  return ;;
    esac
    if "$fp"; then echo flatpak; else echo native; fi
}

# install_file <src> <dest>
#   Back up an existing dest if it differs, then copy src over it.
#   Skips silently when src and dest are byte-identical.
install_file() {
    local src="$1" dest="$2"
    [ -f "$src" ] || { echo -e "${ERROR}Missing source file: $src${NC}" >&2; exit 1; }
    mkdir -p "$(dirname "$dest")"
    if [ -e "$dest" ]; then
        if cmp -s "$src" "$dest"; then
            echo -e "${DIM}  (unchanged — skipping: $dest)${NC}"
            return
        fi
        local backup="$dest.bak.$STAMP"
        cp -p "$dest" "$backup"
        echo -e "${WARNING}  Backed up: $backup${NC}"
    fi
    cp "$src" "$dest"
    echo -e "${SUCCESS}  Installed: $dest${NC}"
}

# inspect_file <path> <label>
#   Prints the file content, announced with the label.
inspect_file() {
    local path="$1" label="$2"
    echo -e "${EMPH}--- ${label} ---${NC}"
    cat "$path"
    echo -e "${EMPH}--- end of ${label} ---${NC}"
    echo
}

####################
### Intro banner ###
####################

echo "${INFO}"
cat << EOF
Logitech Linux Setup — Solaar + Kando dotfiles installer

This script copies the portable presets in this folder into the correct
config directories for Solaar and Kando, auto-detecting whether each app
is a Flatpak or native install.

For each file it will:
  1. Show you exactly what will be written.
  2. Use ${EDITOR_NAME} to let you customise it before installing.
  3. Back up any existing file that differs (timestamped *.bak).
  4. Install the (possibly edited) file.

It will also offer to fix the Wayland uinput permission issue so that
remapped buttons fire keystrokes (optional, Wayland-only, requires sudo).

EOF
echo "${NC}"

if ! ask "begin the installation"; then
    exit 0
fi

#################################
### Part 1: Solaar rules.yaml ###
#################################

echo "${EMPH}"
cat << EOF
###################################
### Part 1: Solaar (rules.yaml) ###
###################################

EOF
echo "${NC}"

echo "${INFO}"
cat << EOF
Installs the Solaar button-remap preset (rules.yaml).
This defines which buttons fire which key events.

Device-specific Solaar options (DPI, backlight, haptic, smart-shift,
scroll ratchet) are stored per physical device and are NOT part of
rules.yaml — set them in the Solaar GUI after pairing.

EOF
echo "${NC}"

if ask "install the Solaar preset"; then

    # Detect install type
    SOLAAR_FP=false; SOLAAR_NAT=false
    flatpak info "$SOLAAR_ID" >/dev/null 2>&1 && SOLAAR_FP=true
    command -v solaar >/dev/null 2>&1 && SOLAAR_NAT=true
    SOLAAR_MODE="$(pick_mode "$SOLAAR_FP")"

    if "$SOLAAR_FP" && "$SOLAAR_NAT"; then
        echo -e "${WARNING}Solaar detected as both Flatpak and native; using ${SOLAAR_MODE} (override with --flatpak/--native).${NC}"
    elif ! "$SOLAAR_FP" && ! "$SOLAAR_NAT" && [ "$FORCE_MODE" = auto ]; then
        echo -e "${WARNING}No Solaar install detected; staging config at the native path for first launch.${NC}"
    fi

    if [ "$SOLAAR_MODE" = flatpak ]; then
        SOLAAR_DIR="$HOME/.var/app/$SOLAAR_ID/config/solaar"
    else
        SOLAAR_DIR="$CONFIG_HOME/solaar"
    fi

    SOLAAR_SRC="$SCRIPT_DIR/solaar/rules.yaml"
    SOLAAR_DEST="$SOLAAR_DIR/rules.yaml"
    SOLAAR_EFFECTIVE="$SOLAAR_SRC"

    echo -e "${INFO}Target: ${EMPH}${SOLAAR_DEST}${NC}\n"

    # Show the file before doing anything
    echo -e "${INFO}Here is what will be installed as rules.yaml:${NC}\n"
    inspect_file "$SOLAAR_SRC" "solaar/rules.yaml"

    # Offer to edit
    if ask_edit; then
        SOLAAR_TMP="$WORK/rules.yaml"
        cp "$SOLAAR_SRC" "$SOLAAR_TMP"
        "${EDITOR:-nano}" "$SOLAAR_TMP" || true
        SOLAAR_EFFECTIVE="$SOLAAR_TMP"
        echo -e "${SUCCESS}Using your edited version.${NC}\n"
    fi

    # Warn if Solaar is running (it can overwrite rules.yaml on exit)
    if pgrep -fi 'solaar' >/dev/null 2>&1; then
        echo -e "${WARNING}"
        cat << EOF
Solaar appears to be running. It reads rules.yaml at startup and rewrites
it when you edit rules in the GUI. Installing while it is running risks
your new rules being overwritten when Solaar exits.

Recommendation: quit Solaar now, then re-run this script.

EOF
        echo "${NC}"
        if ! ask "continue anyway (Solaar still running)"; then
            echo -e "${ERROR}Aborted — quit Solaar and re-run.${NC}"
            exit 1
        fi
    fi

    install_file "$SOLAAR_EFFECTIVE" "$SOLAAR_DEST"

    echo
    echo -e "${INFO}Installed rules.yaml — current content:${NC}\n"
    inspect_file "$SOLAAR_DEST" "$SOLAAR_DEST"

fi

############################
### Part 2: Kando config ###
############################

echo "${EMPH}"
cat << EOF
######################################
### Part 2: Kando (config + menus) ###
######################################

EOF
echo "${NC}"

echo "${INFO}"
cat << EOF
Installs two Kando config files:
  • config.json  — general Kando settings (theme, gestures, etc.)
  • menus.json   — your menu layout (the Actions Ring)

Kando hot-reloads its config files on save, so you do not need to
close it before installing — changes apply immediately.

EOF
echo "${NC}"

if ask "install the Kando preset"; then

    # Detect install type
    KANDO_FP=false; KANDO_NAT=false
    flatpak info "$KANDO_ID" >/dev/null 2>&1 && KANDO_FP=true
    command -v kando >/dev/null 2>&1 && KANDO_NAT=true
    KANDO_MODE="$(pick_mode "$KANDO_FP")"

    if "$KANDO_FP" && "$KANDO_NAT"; then
        echo -e "${WARNING}Kando detected as both Flatpak and native; using ${KANDO_MODE} (override with --flatpak/--native).${NC}"
    elif ! "$KANDO_FP" && ! "$KANDO_NAT" && [ "$FORCE_MODE" = auto ]; then
        echo -e "${WARNING}No Kando install detected; staging config at the native path for first launch.${NC}"
    fi

    if [ "$KANDO_MODE" = flatpak ]; then
        KANDO_DIR="$HOME/.var/app/$KANDO_ID/config/kando"
    else
        KANDO_DIR="$CONFIG_HOME/kando"
    fi

    echo -e "${INFO}Target directory: ${EMPH}${KANDO_DIR}${NC}\n"

    # --- config.json ---
    echo -e "${EMPH}[ config.json — general settings ]${NC}\n"

    KANDO_CFG_SRC="$SCRIPT_DIR/kando/general-settings-backup.json"
    KANDO_CFG_DEST="$KANDO_DIR/config.json"
    KANDO_CFG_EFFECTIVE="$KANDO_CFG_SRC"

    echo -e "${INFO}Here is what will be installed as config.json:${NC}\n"
    inspect_file "$KANDO_CFG_SRC" "kando/general-settings-backup.json → config.json"

    if ask_edit; then
        KANDO_CFG_TMP="$WORK/config.json"
        cp "$KANDO_CFG_SRC" "$KANDO_CFG_TMP"
        "${EDITOR:-nano}" "$KANDO_CFG_TMP" || true
        KANDO_CFG_EFFECTIVE="$KANDO_CFG_TMP"
        echo -e "${SUCCESS}Using your edited version.${NC}\n"
    fi

    install_file "$KANDO_CFG_EFFECTIVE" "$KANDO_CFG_DEST"

    echo
    echo -e "${INFO}Installed config.json — current content:${NC}\n"
    inspect_file "$KANDO_CFG_DEST" "$KANDO_CFG_DEST"

    # --- menus.json ---
    echo -e "${EMPH}[ menus.json — menu layout / Actions Ring ]${NC}\n"

    KANDO_MENU_SRC="$SCRIPT_DIR/kando/menu-settings-backup.json"
    KANDO_MENU_DEST="$KANDO_DIR/menus.json"
    KANDO_MENU_EFFECTIVE="$KANDO_MENU_SRC"

    echo -e "${INFO}Here is what will be installed as menus.json:${NC}\n"
    inspect_file "$KANDO_MENU_SRC" "kando/menu-settings-backup.json → menus.json"

    if ask_edit; then
        KANDO_MENU_TMP="$WORK/menus.json"
        cp "$KANDO_MENU_SRC" "$KANDO_MENU_TMP"
        "${EDITOR:-nano}" "$KANDO_MENU_TMP" || true
        KANDO_MENU_EFFECTIVE="$KANDO_MENU_TMP"
        echo -e "${SUCCESS}Using your edited version.${NC}\n"
    fi

    install_file "$KANDO_MENU_EFFECTIVE" "$KANDO_MENU_DEST"

    echo
    echo -e "${INFO}Installed menus.json — current content:${NC}\n"
    inspect_file "$KANDO_MENU_DEST" "$KANDO_MENU_DEST"

fi

##########################################
### Part 3: Wayland uinput permissions ###
##########################################

echo "${EMPH}"
cat << EOF
#############################################
### Part 3: Wayland uinput fix (optional) ###
#############################################

EOF
echo "${NC}"

echo "${WARNING}"
cat << EOF
This section is OPTIONAL and only needed on Wayland.
X11 sessions use XTEST for synthetic input and are unaffected.

If device settings (battery, DPI, renaming) work in Solaar but remapped
buttons fire no keystroke, your session is missing write access to
/dev/uinput. This section fixes that permanently.

EOF
echo "${NC}"

# The uinput phase requires interactive consent and a real TTY.
# Under -y/--yes or a non-interactive run we skip it entirely.
if "$ASSUME_YES" || [ ! -t 0 ]; then
    echo -e "${DIM}Skipping uinput phase (non-interactive / -y mode).${NC}"
    echo -e "${DIM}Re-run the script interactively to apply this fix.${NC}"
    echo
else

    echo "${INFO}"
    cat << EOF
Here is exactly what this phase will do if you proceed:

  1. Create the file:
       /etc/udev/rules.d/60-uinput.rules
     with the content:
       KERNEL=="uinput", GROUP="input", MODE="0660"
     (The 60- prefix ensures it loads after the shipped 42- rule.)

  2. Run:
       sudo usermod -aG input \$USER
     to add your user account to the 'input' group.

  3. Reload udev:
       sudo udevadm control --reload-rules
       sudo udevadm trigger

  4. A FULL LOG-OUT AND LOG BACK IN is then required for the group
     change to take effect. Reloading udev alone is not enough.

This writes to /etc/udev/rules.d/ and modifies group membership —
both require sudo. Nothing else on your system is changed.

EOF
    echo "${NC}"

    if ask "apply the Wayland uinput fix (requires sudo)"; then

        UINPUT_RULE='KERNEL=="uinput", GROUP="input", MODE="0660"'
        UINPUT_FILE="/etc/udev/rules.d/60-uinput.rules"
        UINPUT_TMP="$WORK/60-uinput.rules"

        printf '%s\n' "$UINPUT_RULE" > "$UINPUT_TMP"

        # Show the rule before installing
        echo -e "${INFO}Rule file that will be written to ${EMPH}${UINPUT_FILE}${INFO}:${NC}\n"
        inspect_file "$UINPUT_TMP" "60-uinput.rules"

        # Offer to edit before installing
        if ask_edit; then
            "${EDITOR:-nano}" "$UINPUT_TMP" || true
            echo -e "${SUCCESS}Using your edited rule.${NC}\n"
        fi

        echo -e "${INFO}Installing udev rule...${NC}"
        sudo install -m 644 "$UINPUT_TMP" "$UINPUT_FILE"
        echo -e "${SUCCESS}  Written: ${UINPUT_FILE}${NC}"

        echo -e "${INFO}Adding $(id -un) to the 'input' group...${NC}"
        sudo usermod -aG input "$(id -un)"
        echo -e "${SUCCESS}  Done.${NC}"

        echo -e "${INFO}Reloading udev rules...${NC}"
        sudo udevadm control --reload-rules && sudo udevadm trigger
        echo -e "${SUCCESS}  udev reloaded.${NC}"

        echo
        echo -e "${WARNING}"
        cat << EOF
uinput fix applied. You MUST log out and log back in fully for the
group change to take effect. A session restart or screen unlock is
not sufficient — you need a complete re-login.

After re-logging in, press a remapped button in a Wayland session
and the assigned keystroke should fire.

EOF
        echo "${NC}"

    fi

fi

########################
### End / next steps ###
########################

echo "${SUCCESS}"
cat << EOF
All done. Next steps:

  Solaar
    (Re)start Solaar so the new rules load. Pair your device,
    then set device-specific options (DPI, backlight, haptic,
    smart-shift) in the GUI — those are per-device and are not
    part of rules.yaml.

  Kando
    Kando hot-reloads, so your menus and settings are already
    live. If not, restart Kando. Remember it must autostart at
    login to be available.

EOF
echo "${DIM}Backups of any replaced files were saved next to them as *.bak.${STAMP}${NC}"
echo

if [ -t 0 ] && ! "$ASSUME_YES"; then
    read -rp "${INFO}Press ENTER to exit...${NC}"
fi

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

############################
### Intro & dependencies ###
############################

echo "${INFO}"
cat << EOF
This script will clone and install keyd.

EOF

echo "${WARNING}"
cat << EOF
Dependencies:
- make
- cc

Please make sure you have these two dependencies installed before proceeding.

EOF
echo "${NC}"

while true; do
    read -p "${PROMPT}Do you want to proceed? [y/n]: ${NC}" yn
    case $yn in
        [yY] ) echo -e "${SUCCESS}\nProceeding...\n${NC}"; break ;;
        [nN] ) echo -e "${ERROR}\nOperation cancelled.\n${NC}"; exit ;;
        * ) echo -e "${WARNING}\nPlease enter y or n.\n${NC}" ;;
    esac
done

########################################
### Clone repo, install, enable keyd ###
########################################

echo -e "${INFO}\nCloning keyd from GitHub repository and installing into system.\n${NC}"
mkdir -p ~/Installations && cd ~/Installations
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install

sudo systemctl enable --now keyd

#########################
### Write keyd config ###
#########################

echo -e "${INFO}\nWriting configuration file for keyd.\n${NC}"
while true; do
    read -p "${PROMPT}Do you want to proceed? [y/n]: ${NC}" yn
    case $yn in
        [yY] ) echo -e "${SUCCESS}\nProceeding...\n${NC}"; break ;;
        [nN] ) echo -e "${ERROR}\nOperation cancelled.\n${NC}"; exit ;;
        * ) echo -e "${WARNING}\nPlease enter y or n.\n${NC}" ;;
    esac
done

TMPFILE=$(mktemp /tmp/default-XXXXXX.conf)
cat > "$TMPFILE" << EOF
# Keyd remaps: Copilot key -> Ctrl; CapsLock -> Backspace,
# Shift + CapsLock -> CapsLock

# Place in /etc/keyd/default.conf

# Edit the file to your liking

[ids]
*

[main]
leftshift+leftmeta+f23 = layer(control)
capslock = backspace

# Shift + capslock for capslock
[shift]
capslock = capslock
EOF
"${EDITOR:-nano}" "$TMPFILE"

sudo mkdir -p /etc/keyd
sudo cp "$TMPFILE" /etc/keyd/default.conf
rm -f "$TMPFILE"

sudo keyd reload

# Verifying content
echo -e "\n"
sudo cat /etc/keyd/default.conf
echo -e "${INFO}\n\nAbove is the content in /etc/keyd/default.conf${NC}"

#############################################
### Configure keyd as internal keyboard   ###
#############################################

echo -e "${INFO}Configuring keyd as internal keyboard.\n${NC}"

while true; do
    read -p "${PROMPT}Do you want to proceed? [y/n]: ${NC}" yn
    case $yn in
        [yY] ) echo -e "${SUCCESS}\nProceeding...\n${NC}"; break ;;
        [nN] ) echo -e "${ERROR}\nOperation cancelled.\n${NC}"; exit ;;
        * ) echo -e "${WARNING}\nPlease enter y or n.\n${NC}" ;;
    esac
done

TMPFILE2=$(mktemp /tmp/local-overrides-XXXXXX.quirks)
cat > "$TMPFILE2" << EOF
# Libinput Local Quirks, configure keyd as internal keyboard
# Save as /etc/libinput/local-overrides.quirks

[Recognise Keyd as Internal Keyboard]

MatchUdevType=keyboard
MatchName=keyd*keyboard
AttrKeyboardIntegration=internal
EOF
"${EDITOR:-nano}" "$TMPFILE2"

sudo mkdir -p /etc/libinput/
# install with mode 644 — libinput parses this file from the user-level compositor and
# silently ignores a root-only (600) quirks file, which is what mktemp + cp would leave behind
sudo install -m 644 "$TMPFILE2" /etc/libinput/local-overrides.quirks
rm -f "$TMPFILE2"

# libinput re-reads quirks files whenever an input device is added — restarting
# keyd re-adds its virtual keyboard, so the new quirk applies without a reboot
sudo systemctl restart keyd

#####################
### End of script ###
#####################

echo "${WARNING}"
cat << EOF
============================================================================
TEST IT: open any text field, start typing, and swipe on the touchpad
WHILE you type. If the pointer stays put, keyd is now treated as an
internal keyboard (disable-while-typing / palm rejection are active).

If nothing changes, log out and back in, then try the typing test again.
============================================================================
EOF
echo "${NC}"

read -rp "${INFO}Press ENTER to exit...${NC}"
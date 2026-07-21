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



#######################
### Testing colours ###
#######################

echo "${INFO}Lorem ipsum dolor salat"
echo "${PROMPT}Lorem ipsum dolor salat"
echo "${SUCCESS}Lorem ipsum dolor salat"
echo "${WARNING}Lorem ipsum dolor salat"
echo "${ERROR}Lorem ipsum dolor salat"
echo "${DIM}Lorem ipsum dolor salat"
echo "${NC}Lorem ipsum dolor salat"



#######################
### Long disclaimer ###
#######################

echo "${WARNING}"
cat << EOF
This is an example of a long disclaimer. Usually used for dependencies. 

Dependencies:
  - make
  - cc
EOF
echo "${NC}"



#########################
### Short annoucement ###
#########################

echo -e "${INFO}\nWriting configuration file for keyd.\n${NC}"



###################
### User prompt ###
###################

while true; do
    read -p "${PROMPT}Do you want to proceed? [y/n]: ${NC}" yn
    case $yn in
        [yY] ) echo -e "${SUCCESS}\nProceeding…\n${NC}"; break ;;
        [nN] ) echo -e "${ERROR}\nOperation cancelled.\n${NC}"; exit ;;
        *    ) echo -e "${WARNING}\nPlease enter y or n.\n${NC}" ;;
    esac
done



#####################
### End of script ###
#####################
read -rp "${INFO}Press ENTER to exit…${NC}"

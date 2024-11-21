#!/bin/bash

# ------------------------------------------------
# install.sh
# ------------------------------------------------

# Define colors
CYAN='\033[0;36m'
RC='\033[0m'

# Define version name
VERSION_NAME="$HOME/Downloads/hyprarch2/.version/latest"

# Install greeter
if command -v figlet >/dev/null 2>&1; then
	clear
	echo -e "${CYAN}"
	figlet -f smslant "Installer"
	echo "Welcome to hyprarch2"
	cat "$VERSION_NAME"
	echo -e "${RC}" && echo ""
else
	clear
	echo -e "${CYAN}"
	cat <<"EOF"
 ___           _        _ _
|_ _|_ __  ___| |_ __ _| | | ___ _ __
 | || '_ \/ __| __/ _` | | |/ _ \ '__|
 | || | | \__ \ || (_| | | |  __/ |
|___|_| |_|___/\__\__,_|_|_|\___|_|
EOF
	echo "Welcome to hyprarch2"
	cat "$VERSION_NAME"
	echo -e "${RC}" && echo ""
fi

# Installation prompt
if [ -n "$SSH_CONNECTION" ]; then
	while true; do
		read -r -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn):" yn
		case $yn in
		[Yy]*)
			echo ";; Starting Installation..."
			sleep 2
			set -e
			break
			;;
		[Nn]*)
			echo ";; Installation canceled..."
			exit
			;;
		*)
			echo ";; Please answer yes or no."
			;;
		esac
	done
else
	if gum confirm "DO YOU WANT TO START THE INSTALLATION NOW?"; then
		echo ";; Starting Installation..."
		sleep 2
		set -e
	elif [ $? -eq 130 ]; then
		echo ";; Installation canceled..."
		exit 130
	else
		echo ";; Installation canceled..."
		exit
	fi
fi

# Define main scripts
PACMAN_CONFIGURATION="$HOME/Downloads/hyprarch2/src/Scripts/pacman.sh"
SYSTEM_INSTALLATION="$HOME/Downloads/hyprarch2/src/.install/setup.sh"
SECURITY_CONFIGURATION="$HOME/src/.install/secure.sh"
CLEANUP_SCRIPT="$HOME/src/.install/hyprclean.sh"
BASHRC="$HOME/.bashrc"

# Execute main scripts
source "$PACMAN_CONFIGURATION"
source "$SYSTEM_INSTALLATION"
source "$SECURITY_CONFIGURATION"
source "$CLEANUP_SCRIPT"
source "$BASHRC"

# End of installation message
echo -e "${CYAN}"
figlet -f smslant "hyprarch2"
echo ""
echo ";; Installation status: COMPLETE"
echo ""
echo -e "${RC}"

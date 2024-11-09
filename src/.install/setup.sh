#!/bin/bash

# -----------------------------------------------------
# setup.sh
# -----------------------------------------------------

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RC='\033[0m'

# Define variables
PACMAN_PACKAGES="$HOME/Downloads/hyprarch2/src/packages/pacman_packages.txt"
WALLPAPER_REPO="https://github.com/g5ostXa/wallpaper.git"
WALLPAPER_DIR="$HOME/wallpaper"
HYPRARCH2_DIR="$HOME/Downloads/hyprarch2"

# Script banner
echo -e "${CYAN}==========================${RC}"
echo -e "${CYAN}---> RUNNING SETUP.SH <---${RC}"
echo -e "${CYAN}==========================${RC}"
sleep 3

sudo pacman -Syu && sudo pacman -S --needed - <"$PACMAN_PACKAGES"
clear

# Check if figlet is installed
is_installed_figlet() {
	if ! command -v figlet >/dev/null 2>&1; then
		echo -e "${RED};; figlet is not installed...${RC}"
		exit 1
	fi

}

# Check if gum is installed
is_installed_gum() {
	if ! command -v gum >/dev/null 2>&1; then
		echo -e "${RED};; gum is not installed...${RC}"
		exit 1
	fi

}

# Check if git is installed
is_installed_git() {
	if ! command -v git >/dev/null 2>&1; then
		echo -e "${RED};; git is not installed...${RC}"
		exit 1
	fi

}

# Run checks and display figlet banner
is_installed_figlet
echo -e "${CYAN}"
figlet -f smslant "AUR"
echo -e "${RC}" && echo ""
is_installed_gum
is_installed_git

# Run main operation if all checks passed
echo -e "${YELLOW};; Please choose option:${RC}" && echo ""
AUR_HELPER=$(gum choose "yay" "paru" "aura" "CANCEL")

if [ -n "$AUR_HELPER" ]; then
	if [[ ! "$AUR_HELPER" == "CANCEL" ]]; then
		cd && git clone https://aur.archlinux.org/"$AUR_HELPER"-bin
		cd "$AUR_HELPER"-bin && makepkg -si && cd
	else
		echo -e "${RED};; Operation canceled... :(${RC}"
		exit 0
	fi
else
	exit 1
fi

"$AUR_HELPER" -S --needed --noconfirm bibata-cursor-theme dracula-icons-theme pacseek-bin tokyonight-gtk-theme-git trizen typos-lsp-bin vim-language-server vscodium-bin waypaper wlogout

install_wallpaper() {
	if [ -d "$WALLPAPER_DIR" ]; then
		echo -e "${YELLOW}Installing wallpapers...${RC}"
		sleep 1
		rm -rf "$WALLPAPER_DIR"
		cd && git clone "$WALLPAPER_REPO"
	else
		echo -e "${YELLOW}Installing wallpapers...${RC}"
		sleep 1
		cd && git clone "$WALLPAPER_REPO"
	fi

	if [ $? -eq 0 ]; then
		echo -e "${GREEN}Installed wallpaper !${RC}"
		sleep 2
	else
		echo "${RED}Failed to install wallpaper...${RC}"
		sleep 2
	fi

}

copy_files() {
	if [ -f "$HOME/.bashrc" ]; then
		rm -rf "$HOME/.bashrc"
	fi

	if [ ! -d "$HYPRARCH2_DIR" ]; then
		echo -e "${RED}$HYPRARCH2_DIR directory does not exist, exiting...${RC}"
		exit 1
	else
		cp -r "$HYPRARCH2_DIR"/* "$HOME/"
		sudo cp -r "$HYPRARCH2_DIR/dotfiles/login/issue" "/etc/"
		sudo chown -R root: /etc/issue
	fi

	if [ -f "$HOME/.bashrc" ]; then
		echo -e "${YELLOW}$HOME/.bashrc exits...${RC}"
	else
		echo -e "${YELLOW}Copying .bashrc to home folder...${RC}"
		cp -r "$HYPRARCH2_DIR/.bashrc" "$HOME/"
	fi

	if [ -d "$HOME/.version/" ]; then
		echo -e "${YELLOW}$HOME/.version/ exists...${RC}"
	else
		echo -e "${YELLOW}Copying .version/ to home folder...${RC}"
		cp -r "$HYPRARCH2_DIR/.version/" "$HOME/"
	fi

	sleep 2

}

create_symlinks() {
	ln -s ~/dotfiles/gtk/.Xresources ~/
	ln -s ~/dotfiles/alacritty/ ~/.config/
	ln -s ~/dotfiles/dunst/ ~/.config/
	ln -s ~/dotfiles/gtk/gtk-3.0/ ~/.config/
	ln -s ~/dotfiles/gtk/gtk-4.0/ ~/.config/
	ln -s ~/dotfiles/hypr/ ~/.config/
	ln -s ~/dotfiles/nvim/ ~/.config/
	ln -s ~/dotfiles/rofi/ ~/.config/
	ln -s ~/dotfiles/starship/ ~/.config/
	ln -s ~/dotfiles/swappy/ ~/.config/
	ln -s ~/dotfiles/vim/ ~/.config/
	ln -s ~/dotfiles/wal ~/.config/
	ln -s ~/dotfiles/waybar/ ~/.config/
	ln -s ~/dotfiles/wlogout/ ~/.config/
	ln -s ~/dotfiles/fastfetch/ ~/.config/
	ln -s ~/dotfiles/fish/ ~/.config/
	ln -s ~/dotfiles/pacseek/ ~/.config/
	ln -s ~/dotfiles/waypaper/ ~/.config/

}

install_wallpaper
copy_files
create_symlinks

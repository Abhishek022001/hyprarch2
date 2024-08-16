#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RC='\033[0m'

echo -e "${CYAN}===========================${RC}"
echo -e "${CYAN}---> RUNNING SECURE.SH <---${RC}"
echo -e "${CYAN}===========================${RC}"
sleep 3

sysctl_dir="/etc/sysctl.d/"
sysctl_source_dir="$HOME/sysctl"
dnsmasq_config="/etc/dnsmasq.conf"

ufw_config() {
	echo -e "${CYAN}Installing and configuring UFW...${RC}"
	sudo pacman -S --noconfirm ufw
	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw enable && sudo systemctl enable ufw.service

	echo -e "${CYAN}==> NOTE:${RC}"
	echo -e "${YELLOW}-> A reboot is required for the firewall to be enabled and active!${RC}"
	echo -e "${YELLOW}-> The installation will continue in 5 seconds...${RC}"
	sleep 6
}

# Function to apply sysctl hardening (kernel and networking)
sysctl_hardening() {
	echo -e "${YELLOW}Checking if $sysctl_dir exists...${RC}"

	if [ -d "$sysctl_dir" ]; then
		echo -e "${GREEN}$sysctl_dir exists, proceeding with sysctl hardening...${RC}"
	else
		echo -e "${YELLOW}$sysctl_dir does not exist, creating directory...${RC}"
		sudo mkdir -p "$sysctl_dir"
		echo -e "${GREEN}$sysctl_dir created!${RC}"
	fi

	sleep 2

	if [ -d "$sysctl_source_dir" ]; then
		echo -e "${YELLOW}Copying sysctl configurations from $sysctl_source_dir to $sysctl_dir...${RC}"
		sudo cp -r "$sysctl_source_dir"/* "$sysctl_dir"
		sudo chown -R root:root "$sysctl_dir"/*
		sudo sysctl --system
		echo -e "${GREEN}Sysctl hardening applied successfully!${RC}"
	else
		echo -e "${RED}Source directory $sysctl_source_dir does not exist. Aborting sysctl hardening.${RC}"
	fi
}

config_dnsmasq() {
	if [ -f "$dnsmasq_config" ]; then
		echo -e "${YELLOW}Configuring dnsmasq...${RC}"
		sleep 1
	else
		echo -e "${RED}:: ERROR: dnsmasq may not be installed, or the config file doesn't exist. Skipping...${RC}"
		return 1
	fi

	if systemctl is-enabled --quiet dnsmasq.service; then
		echo -e "${GREEN}dnsmasq is already configured and enabled...${RC}"
		return 1
	elif command -v dnsmasq >/dev/null 2>&1; then
		sudo sed -i '/^#conf-file=\/usr\/share\/dnsmasq\/trust-anchors.conf/s/^#//g' "$dnsmasq_config"
		sudo sed -i '/^#dnssec/s/^#//g' "$dnsmasq_config"
		sudo sed -i '/^#bind-interfaces/s/^#//g' "$dnsmasq_config"
		sudo systemctl enable dnsmasq.service
		echo -e "${GREEN}Configuration updated and dnsmasq service enabled!${RC}"
	else
		echo -e "${RED}dnsmasq is not installed. Skipping...${RC}"
		return 1
	fi
}

# Check if ufw is enabled
if ! systemctl is-enabled --quiet ufw.service; then
	ufw_config
else
	echo -e "${GREEN}UFW is already enabled.${RC}"
fi

sysctl_hardening
config_dnsmasq

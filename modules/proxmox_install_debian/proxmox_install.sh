#!/bin/bash

# Init env "proxmox_user" from arg
PVE_USERNAME=$1
PVE_PASS=$2

# Noninteractive var
export DEBIAN_FRONTEND=noninteractive

# Mark bootable disk
boot_disk=$(lsblk -o NAME,MOUNTPOINT | grep '/boot' | cut -d ' ' -f 1 | head -n 1 | sed 's/[^a-zA-Z0-9]//g')
echo "grub-pc grub-pc/install_devices_empty boolean false" | debconf-set-selections
echo "grub-pc grub-pc/install_devices string /dev/$boot_disk" | debconf-set-selections
echo "grub-pc grub-pc/bootdev string /dev/$boot_disk" | debconf-set-selections

# Init version OS
debian_version=$(lsb_release -c | sed 's/.*:\s*//')

apt update -y

# Install needed packets
apt install -y wget curl gnupg lsb-release libguestfs-tools

# Add Proxmox repository
echo "deb http://download.proxmox.com/debian/pve $debian_version pve-no-subscription" | sudo tee /etc/apt/sources.list.d/pve-no-subscription.list

# Add key for Proxmox repository
wget https://enterprise.proxmox.com/debian/proxmox-release-$debian_version.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-$debian_version.gpg && apt update -y

# Install Proxmox
apt install -y proxmox-ve postfix open-iscsi

#Remove enterprise repo
rm -r /etc/apt/sources.list.d/pve-enterprise.list

# Create PVE user with all privileges
pveum user add $PVE_USERNAME@pve -password $PVE_PASS && 
pveum acl modify / -user $PVE_USERNAME@pve --roles Administrator

# Create API-token with all privileges
pveum user token add $PVE_USERNAME@pve token --privsep 0 > /root/apikey
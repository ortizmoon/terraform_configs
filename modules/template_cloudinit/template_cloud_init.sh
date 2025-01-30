#!/bin/bash

# Install packets
apt install -y libguestfs-tools

# Set variables
IMAGES_PATH="/mnt/pve/STORAGE/"
IMAGE_URL="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
VM_NAME="Ubuntu2204"
TEMPLATE_ID=1000
VM_DISK_IMAGE="${IMAGES_PATH}/jammy-server-cloudimg-amd64.img"
VM_CPU_CORES=2
VM_CPU_SOCKETS=1
VM_MEMORY=4098
VM_STORAGE_NAME="STORAGE"
VM_BRIDGE_NAME="vmbr0"
CLOUD_INIT_USER="user"
CLOUD_INIT_PASSWORD="123"
CLOUD_INIT_IP="dhcp"
CLOUD_INIT_NAMESERVER="8.8.8.8"
CLOUD_INIT_SEARCHDOMAIN="google.com"

# Download and prepare image
cd $IMAGES_PATH
wget $IMAGE_URL
virt-customize --install qemu-guest-agent -a $VM_DISK_IMAGE

# Create VM
qm create $TEMPLATE_ID --name $VM_NAME --cpu host --sockets $VM_CPU_SOCKETS --cores $VM_CPU_CORES --memory $VM_MEMORY --net0 virtio,bridge=$VM_BRIDGE_NAME --ostype l26 --agent 1 --scsihw virtio-scsi-single

# Set Disk, Cloud-Init, and Network
qm set $TEMPLATE_ID --virtio0 $VM_STORAGE_NAME:0,import-from=$VM_DISK_IMAGE
qm set $TEMPLATE_ID --ide2 $VM_STORAGE_NAME:cloudinit --boot order=virtio0
qm set $TEMPLATE_ID --ipconfig0 ip=$CLOUD_INIT_IP --nameserver $CLOUD_INIT_NAMESERVER --searchdomain $CLOUD_INIT_SEARCHDOMAIN
qm set $TEMPLATE_ID --ciupgrade 1 --ciuser $CLOUD_INIT_USER --cipassword $CLOUD_INIT_PASSWORD

# Finalize
qm cloudinit update $TEMPLATE_ID
qm set $TEMPLATE_ID --name "$VM_NAME-Template"
qm template $TEMPLATE_ID
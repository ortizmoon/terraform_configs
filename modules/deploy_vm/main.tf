terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}
provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
}
resource "proxmox_vm_qemu" "ubuntu2204" {
  count = 3
  name = "${var.vm_name}-${count.index + 1}"
  target_node = var.nodes_name
  clone       = var.template_name
  agent       = 1
  os_type     = "cloud-init"
  cores       = 1
  sockets     = 2
  memory      = 2048
  scsihw      = "virtio-scsi-single"
  bootdisk = "scsi0"

  disks {
    # Cloud-init disk, using IDE for cloud-init configuration
    ide {
      ide2 {
        cloudinit {
          storage = var.storage_name
        }
      }
    }

    # Main system disk
    virtio {
      virtio0 {
        disk {
          size      = "2252M"
          storage   = var.storage_name
          replicate = true
          iothread  = "1"
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  boot      = "order=virtio0"
  #ipconfig0   = "ip=10.128.0.10${count.index + 1}/20,gw=10.128.0.1"
  ipconfig0   = "ip=dhcp"
  nameserver = "8.8.8.8"
  ciuser   = "ortiz"
  cipassword = "123"
  sshkeys = var.ssh_public_key
}
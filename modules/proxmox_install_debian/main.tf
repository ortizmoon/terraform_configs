terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

resource "null_resource" "install_proxmox" {
  connection {
    type        = "ssh"
    host        = var.server_ip
    user        = var.ssh_user
    private_key = file(var.private_key)
    timeout     = "2m"
  }

  
  provisioner "file" {
    source      = "./modules/proxmox_install_debian/proxmox_install.sh"
    destination = "/tmp/proxmox_install.sh"
  }
  
  provisioner "remote-exec" {
    inline = [

      "chmod +x /tmp/proxmox_install.sh",

      "sudo /tmp/proxmox_install.sh"
      
    ]
  }
}

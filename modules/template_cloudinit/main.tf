terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

resource "null_resource" "template_cloudinit" {
  connection {
    type        = "ssh"
    host        = var.server_ip
    user        = var.ssh_user
    private_key = file(var.private_key)
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "./modules/template_cloudinit/template_cloud_init.sh"
    destination = "/tmp/template_cloud_init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/template_cloud_init.sh",
      "sudo /tmp/template_cloud_init.sh"
    ]
  }
}
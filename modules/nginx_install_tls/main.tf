terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

resource "null_resource" "install_nginx" {

  connection {
    type        = "ssh"
    host        = var.server_ip
    user        = var.ssh_user
    private_key = file(var.private_key)
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "./modules/nginx_install_tls/nginx_install.sh"
    destination = "/tmp/nginx_install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx_install.sh",
      "sudo /tmp/nginx_install.sh ${var.domain_name}"
    ]
  }
}
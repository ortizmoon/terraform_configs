terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }

}
}
# module "proxmox_install" {
#   source     = "./modules/proxmox_install_debian"
#   server_ip  = var.server_ip
#   ssh_user   = var.ssh_user
#   private_key = var.private_key
#   proxmox_user = var.proxmox_user
#   proxmox_pass = var.proxmox_pass
  
# }

# module "nginx_install_tls" {
#   source     = "./modules/nginx_install_tls"
#   server_ip  = var.server_ip
#   ssh_user   = var.ssh_user
#   private_key = var.private_key
#   domain_name = var.domain_name

#   depends_on = [module.proxmox_install]
# }

module "template_cloudinit" {
   source     = "./modules/template_cloudinit"
   server_ip  = var.server_ip
   ssh_user   = var.ssh_user
   private_key = var.private_key
}
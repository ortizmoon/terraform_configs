terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
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


module "deploy_vm" {
  source = "./modules/deploy_vm"
  pm_api_url        = var.pm_api_url
  pm_api_token_id   = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  storage_name           = var.storage_name
  vm_name                = var.vm_name
  nodes_name = var.nodes_name
  template_name = var.template_name
  ssh_public_key = var.ssh_public_key
#  depends_on = [module.template_cloudinit]
}


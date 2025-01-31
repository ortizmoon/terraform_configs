variable "server_ip" {
  description = "Remote IP"
  type        = string
}

variable "ssh_user" {
  description = "User SSH"
  type        = string
}

variable "private_key" {
  description = "Path for privatekey SSH"
  type        = string
}

variable "domain_name" {
  description = "Domain name for script"
  type        = string
}

output "domain_name" {
  value = var.domain_name
}

variable "proxmox_user" {
  description = "PVE User"
  type        = string
}

variable "proxmox_pass" {
  description = "PVE pass"
  type        = string
}

variable "pm_api_url" {
  description = "URL of the Proxmox API."
  type        = string
}

variable "pm_api_token_id" {
  description = "API token ID for Proxmox."
  type        = string
}

variable "pm_api_token_secret" {
  description = "API token secret for Proxmox."
  type        = string
}

variable "storage_name" {
  description = "The name of the storage for the VM."
  type        = string
}

variable "vm_name" {
  description = "The name of the VM to deploy."
  type        = string
}

variable "template_name" {
  description = "The name of the VM to deploy."
  type        = string
}

variable "nodes_name" {
  description = "The node-proxmox name."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH pubkey"
  type        = string
}
# output "proxmox_pass" {
#   value = var.proxmox_pass
# }
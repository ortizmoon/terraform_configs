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

variable "proxmox_user" {
  description = "PVE User"
  type        = string
}

# output "proxmox_user" {
#   value = var.proxmox_user
# }
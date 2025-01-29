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

variable "proxmox_api_token" {
  description = "API-token for Proxmox"
  type        = string
}
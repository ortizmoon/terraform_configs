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
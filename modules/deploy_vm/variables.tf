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
  description = "The template name for VM to deploy."
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



variable "subscription_id" {
  description = "The Azure subscription ID where resources will be created."
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID for authentication."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "mini_project_RG_prod"
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
  default     = "prodVM"
}

variable "ssh_public_key" {
  description = "SSH public key for admin user"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {
    environment = "prod"
  }
}

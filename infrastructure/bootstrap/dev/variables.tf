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
  default     = "remote_state_RG_dev"
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "westeurope"
}

variable "storage_account_name" {
  description = "The name of the storage account for the Terraform backend."
  type        = string
  default     = "avichai98sadev"
}

variable "container_name" {
  description = "The name of the container for the Terraform backend."
  type        = string
  default     = "remotecontainerdev"
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {
    environment = "dev"
  }
}
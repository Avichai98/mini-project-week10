variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
}

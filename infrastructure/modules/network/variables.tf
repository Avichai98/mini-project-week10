variable "subnet_address_prefix" {
  description = "The address prefix for the subnet."
  type        = list(string)
  default     = ["10.123.1.0/24"]
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.123.0.0/16"]
}

variable "app_ports" {
  description = "List of application ports to allow."
  type        = list(number)
  default     = [8000, 3000]
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
}

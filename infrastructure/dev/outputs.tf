output "public_ip_address" {
  description = "The public IP address of the virtual machine."
  value       = module.network.public_ip_address
}

output "virtual_machine_id" {
  description = "The ID of the created virtual machine."
  value       = module.virtual_machine.virtual_machine_id
}

output "admin_username" {
  description = "The administrator username used for the VM."
  value       = module.virtual_machine.admin_username
}

output "ssh_connection_string" {
  description = "SSH connection string to the virtual machine."
  value       = "ssh -i ${module.virtual_machine.admin_ssh_private_key_path} ${module.virtual_machine.admin_username}@${module.network.public_ip_address}"
}

output "resource_group_name" {
  description = "The name of the resource group where resources are created."
  value       = module.resource_group.resource_group_name
}

output "source_image_reference" {
  description = "The source image reference used for the virtual machine."
  value       = module.virtual_machine.source_image_reference
}

output "address_space" {
  description = "The address space of the virtual network."
  value       = module.network.address_space
}

output "subnet_address_prefix" {
  description = "The address prefix of the subnet."
  value       = module.network.subnet_address_prefix
}

output "app_ports" {
  description = "The application ports allowed in the network security group."
  value       = module.network.app_ports
}
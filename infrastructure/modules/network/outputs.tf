output "public_ip_address" {
  description = "The public IP address of the network."
  value       = azurerm_public_ip.public_ip.ip_address
}

output "subnet_id" {
  description = "The ID of the created subnet."
  value       = azurerm_subnet.subnet.id
}

output "address_space" {
  description = "The address space of the virtual network."
  value       = azurerm_virtual_network.vnet.address_space
}

output "subnet_address_prefix" {
  description = "The address prefix of the subnet."
  value       = azurerm_subnet.subnet.address_prefixes
}

output "app_ports" {
  description = "The application ports allowed in the network security group."
  value       = azurerm_network_security_rule.allow_app_ports.destination_port_ranges
}

output "nic_id" {
  description = "The ID of the network interface."
  value       = azurerm_network_interface.nic.id
}
output "virtual_machine_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "admin_username" {
  value = azurerm_linux_virtual_machine.vm.admin_username
}

output "source_image_reference" {
  value = azurerm_linux_virtual_machine.vm.source_image_reference
}

output "admin_ssh_private_key_path" {
  value = var.admin_ssh_private_key_path
}
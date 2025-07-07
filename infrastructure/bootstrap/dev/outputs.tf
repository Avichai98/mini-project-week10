output "resource_group_name" {
  description = "The name of the resource group where the storage account is created."
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "The name of the storage account created."
  value       = azurerm_storage_account.sa.name
}

output "container_name" {
  description = "The name of the container created."
  value       = azurerm_storage_container.terraform.name
}
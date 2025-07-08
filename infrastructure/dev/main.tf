terraform {
  backend "azurerm" {
    resource_group_name  = "remote_state_RG_dev"
    storage_account_name = "avichai98sadev"
    container_name       = "remotecontainerdev"
    key                  = "remotecontainerdev.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

module "resource_group" {
  source = "../modules/resource_group"
  resource_group_name = var.resource_group_name
  tags   = var.tags
}

module "network" {
  source              = "../modules/network"
  resource_group_name = var.resource_group_name
  location            = module.resource_group.location
  tags                = var.tags
}

module "virtual_machine" {
  source              = "../modules/virtual_machine"
  location            = module.resource_group.location
  resource_group_name = var.resource_group_name
  vm_name             = var.vm_name
  nic_id              = module.network.nic_id
  public_ip           = module.network.public_ip_address
  ssh_public_key      = var.ssh_public_key
  tags                = var.tags
}

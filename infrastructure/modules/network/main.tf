resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-mini-project"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    environment = var.tags["environment"]
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-mini-project"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-mini-project"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    environment = var.tags["environment"]
  }
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "allow-ssh"
  description                 = "Allow SSH traffic"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_app_ports" {
  name                        = "allow-app-ports"
  description                 = "Allow application ports"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = var.app_ports
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-mini-project"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = var.tags["environment"]
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-mini-project"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig-mini-project"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.public_ip.id
  }
}
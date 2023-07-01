# https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "vnet" {
  resource_type = "azurerm_virtual_network"
  prefixes      = var.global_settings.azurecaf_name.prefixes
}

resource "azurecaf_name" "snet" {
  resource_type  = "azurerm_subnet"
  prefixes       = var.global_settings.azurecaf_name.prefixes
  suffixes       = ["private-endpoints"]
  resource_types = ["azurerm_network_security_group"]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "this" {
  name                = azurecaf_name.vnet.result
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.virtual_network.address_space]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "this" {
  name                 = azurecaf_name.snet.result
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.virtual_network.subnets.virtual_machine.address_space]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "this" {
  name                = azurecaf_name.snet.results["azurerm_network_security_group"]
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association
resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule
resource "azurerm_network_security_rule" "this" {
  name                        = "AllowVirtualMachineInBound"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22"]
  source_address_prefix       = var.client_ip.cidr
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.this.name
}

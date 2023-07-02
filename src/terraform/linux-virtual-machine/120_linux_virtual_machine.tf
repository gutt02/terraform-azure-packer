# https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "vm" {
  resource_type  = "azurerm_linux_virtual_machine"
  prefixes       = var.global_settings.azurecaf_name.prefixes
  resource_types = ["azurerm_public_ip", "azurerm_network_interface", "azurerm_managed_disk"]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "this" {
  name                = azurecaf_name.vm.results["azurerm_public_ip"]
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  allocation_method = "Dynamic"
  domain_name_label = azurecaf_name.vm.result
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "this" {
  name                = azurecaf_name.vm.results["azurerm_network_interface"]
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "IpConfig"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "this" {
  name                = azurecaf_name.vm.result
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  admin_username = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(".ssh/id_rsa.pub")
  }

  identity {
    type = "SystemAssigned"
  }

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  os_disk {
    name                 = "${azurecaf_name.vm.result}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  size            = var.linux_virtual_machine.size
  source_image_id = data.azurerm_shared_image_version.this.id
}

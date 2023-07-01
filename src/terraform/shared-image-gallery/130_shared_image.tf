# https://registry.terraform.io/providers/hashicorp/azurerm/1.44.0/docs/resources/shared_image
resource "azurerm_shared_image" "this" {
  name                = "Ubuntu-22.04-LTS-CF"
  gallery_name        = azurerm_shared_image_gallery.this.name
  location            = var.location
  resource_group_name = azurerm_resource_group.sig.name
  os_type             = "Linux"

  identifier {
    publisher = "AzCfSig"
    offer     = "UbuntuServerCF"
    sku       = "22.04-LTS-CF"
  }
}

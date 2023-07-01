# https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "sig" {
  resource_type = "azurerm_shared_image_gallery"
  prefixes      = var.global_settings.azurecaf_name.prefixes
}


# https://registry.terraform.io/providers/hashicorp/azurerm/1.44.0/docs/resources/shared_image_gallery
resource "azurerm_shared_image_gallery" "this" {
  name                = azurecaf_name.sig.result
  location            = var.location
  resource_group_name = azurerm_resource_group.sig.name
  description         = "Azure Cloud Foundation Shared Images."
}

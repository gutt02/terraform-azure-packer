# https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name
resource "azurecaf_name" "st" {
  resource_type = "azurerm_storage_account"
  prefixes      = var.global_settings.azurecaf_name.prefixes
  suffixes      = ["001"]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "this" {
  name                     = azurecaf_name.st.result
  location                 = var.location
  resource_group_name      = azurerm_resource_group.sig.name
  account_tier             = "Standard"
  account_replication_type = "ZRS"

  identity {
    type = "SystemAssigned"
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container.html
resource "azurerm_storage_container" "this" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

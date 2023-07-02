output "resource_group_name_shared_image_gallery" {
  value = azurerm_resource_group.sig.name
}

output "resource_group_name_managed_image" {
  value = azurerm_resource_group.managed_image.name
}

output "shared_image_gallery_name" {
  value = azurerm_shared_image_gallery.this.name
}

output "shared_image_id" {
  value = azurerm_shared_image.this.id
}

output "shared_image_name" {
  value = azurerm_shared_image.this.name
}

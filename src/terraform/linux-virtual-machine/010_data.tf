locals {
  resource_regex_shared_image = "(?i)subscriptions/(.+)/resourceGroups/(.+)/providers/Microsoft.Compute/galleries/(.+)/images/(.+)"
  subscription_id             = regex(local.resource_regex_shared_image, var.shared_image_id)[0]
  resource_group_name         = regex(local.resource_regex_shared_image, var.shared_image_id)[1]
  shared_image_gallery_name   = regex(local.resource_regex_shared_image, var.shared_image_id)[2]
  shared_image_name           = regex(local.resource_regex_shared_image, var.shared_image_id)[3]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/shared_image_version
data "azurerm_shared_image_version" "this" {
  name                = "latest"
  image_name          = local.shared_image_name
  gallery_name        = local.shared_image_gallery_name
  resource_group_name = local.resource_group_name
}

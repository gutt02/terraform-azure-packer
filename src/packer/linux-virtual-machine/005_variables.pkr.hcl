variable client_id {
  type        = string
  description = "Client id of the service principal."
}

variable "client_secret" {
  type        = string
  sensitive   = true
  description = "Client secret of the service principal."
}

variable "subscription_id" {
  type        = string
  description = "Id of the subscription for the deployment."
}

variable "tenant_id" {
  type        = string
  description = "Id of the tenant of the subscription."
}

variable "linux_virtual_machine" {
  type = object({
    image_offer     = string
    image_publisher = string
    image_sku       = string
    os_type         = string
    vm_size         = string
  })

  default = {
    image_offer     = "0001-com-ubuntu-server-jammy"
    image_publisher = "canonical"
    image_sku       = "22_04-lts"
    os_type         = "Linux"
    vm_size         = "Standard_B2s"
  }
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Default Azure region, use Azure CLI notation."
}

variable "gallery_name" {
  type        = string
  description = "Name of the Shared Image Gallery."
}

variable "resource_group_name_managed_image" {
  type        = string
  description = "Name of the Resource Group of the Shared Image Gallery."
}

variable "resource_group_name_shared_image_gallery" {
  type        = string
  description = "Name of the Resource Group of the Shared Image Gallery."
}

variable "shared_image_name" {
  type        = string
  description = "Name of the Shared Image."
}
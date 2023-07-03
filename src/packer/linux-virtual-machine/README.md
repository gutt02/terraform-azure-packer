# Packer - Azure - Linux Virtual Machine

## Table of Contents

## Introduction

A packer script to create a customized Ubuntu virtual machine image.

## Variables

```hcl
variable client_id {
  type        = string
  description = "Client id of the service principal."
}
```

```hcl
variable "client_secret" {
  type        = string
  sensitive   = true
  description = "Client secret of the service principal."
}
```

```hcl
variable "subscription_id" {
  type        = string
  description = "Id of the subscription for the deployment."
}
```

```hcl
variable "tenant_id" {
  type        = string
  description = "Id of the tenant of the subscription."
}
```

```hcl
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

  description = "Basis for the virtual machine image."
}
```

```hcl
variable "location" {
  type        = string
  default     = "westeurope"
  description = "Default Azure region, use Azure CLI notation."
}
```

```hcl
variable "gallery_name" {
  type        = string
  description = "Name of the Shared Image Gallery."
}
```

```hcl
variable "resource_group_name_managed_image" {
  type        = string
  description = "Name of the Resource Group of the Shared Image Gallery."
}
```

```hcl
variable "resource_group_name_shared_image_gallery" {
  type        = string
  description = "Name of the Resource Group of the Shared Image Gallery."
}
```

```hcl
variable "shared_image_name" {
  type        = string
  description = "Name of the Shared Image."
}
```

## Resources

* [Packer by HashiCorp](https://www.packer.io/)
* [Packer Plugin Azure](https://github.com/hashicorp/packer-plugin-azure)

# Terraform - Azure - Shared Image Gallery

## Table of Contents

* [Introduction](#introduction)
* [Azure Resources](#azure-resources)
* [Variables](#variables)
* [Output](#output)

## Introduction

Few script to create a shared image gallery and a shared imaged used by packer to provide a customized Ubuntu virtual machine image.

> The shared image versions must be deleted manually before the resources can be destroyed with Terraform.

## Azure Resources

* Resource Group
* Storage Account
* Shared Image Gallery
* Shared Image

## Variables

```hcl
variable "client_secret" {
  type        = string
  sensitive   = true
  description = "Client secret of the service principal."
}
```

```hcl
variable "global_settings" {
  type    = any
  default = {
    azurecaf_name = {
      prefixes = ["az", "cf", "sig"]
    }
  }

  description = "Global settings."
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
variable "tags" {
  type = object({
    created_by  = string
    contact     = string
    customer    = string
    environment = string
    project     = string
  })

  default = {
    created_by  = "azc-iac-acf-sp-tf"
    contact     = "contact@me"
    customer    = "Azure"
    environment = "Cloud Foundation"
    project     = "Shared Image Gallery"
  }

  description = "Default tags for resources, only applied to resource groups."
}
```

## Output

```hcl
output "resource_group_name_shared_image_gallery" {
  value = azurerm_resource_group.sig.name
}
```

```hcl
output "resource_group_name_managed_image" {
  value = azurerm_resource_group.managed_image.name
}
```

```hcl
output "shared_image_gallery_name" {
  value = azurerm_shared_image_gallery.this.name
}
```

```hcl
output "shared_image_id" {
  value = azurerm_shared_image.this.id
}
```

```hcl
output "shared_image_name" {
  value = azurerm_shared_image.this.name
}
```

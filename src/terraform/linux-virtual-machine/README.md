# Terraform - Azure - Linux Virtual Machine

## Table of Contents

* [Introduction](#introduction)
* [Azure Resources](#azure-resources)
* [Variables](#variables)
* [Output](#output)

## Introduction

Few scripts to create a Linux virtual machine based on the customized Ubuntu virtual machine image.

## Azure Resources

* Resource Group
* Virtual Network and Subnet
* Linux Virtual Machine

## Variables

```hcl
variable "admin_username" {
  type        = string
  sensitive   = true
  description = "Linux Virtual Machine Admin User."
}
```

```hcl
# curl ipinfo.io/ip
variable "client_ip" {
  type = object({
    name             = string
    cidr             = string
    start_ip_address = string
    end_ip_address   = string
  })

  description = "Client ip."
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
variable "global_settings" {
  type = any
  default = {
    azurecaf_name = {
      prefixes = ["az", "cf", "sig", "lvm"]
    }
  }

  description = "Global settings."
}
```

```hcl
variable "linux_virtual_machine" {
  type = object({
    size = string
  })

  default = {
    size = "Standard_B2s"
  }

  description = "Linux Virtual Machine."
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
variable "shared_image_id" {
  type        = string
  description = "Id of the shared image."
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

```hcl
variable "virtual_network" {
  type = object({
    address_space = string

    subnets = map(object({
      name          = string
      address_space = string
    }))
  })

  default = {
    address_space = "192.168.0.0/24"

    subnets = {
      virtual_machine = {
        name          = "virtual-machine"
        address_space = "192.168.0.0/28"
      }
    }
  }

  description = "VNET details."
}
```

## Output

```hcl
output "domain_name_label" {
  value = azurerm_public_ip.this.fqdn
}
```

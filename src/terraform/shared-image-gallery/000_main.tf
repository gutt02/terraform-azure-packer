terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.58.0"
    }

    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview3"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azurecaf" {}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "client_config" {}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription
data "azurerm_subscription" "subscription" {}

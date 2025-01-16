
terraform {

  required_version = "~>1.8"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-fiap"
    storage_account_name = "safiapterraform"
    container_name       = "terraform-state"
    key                  = "latest/infrastructure.tfstate"
  }

}

provider "github" {
  owner = "renata-gotler" # Troque pela sua conta pessoal ou organização
}

provider "azurerm" {
  features {}
}

module "github" {
  source = "./github"
}

module "azure" {
  source = "./azure"
}

import {
  id = "ai_product_template"
  to = module.github.github_repository.this["ai_product_template"]
}

import {
  id = "asl-ml-immersion"
  to = module.github.github_repository.this["asl-ml-immersion"]
}

import {
  id = "studies"
  to = module.github.github_repository.this["studies"]
}

import {
  id = "/subscriptions/54a7ac13-c663-459e-aab5-74db69b7d7fe/resourceGroups/rg-fiap"
  to = module.azure.azurerm_resource_group.this
}

import {
  id = "/subscriptions/54a7ac13-c663-459e-aab5-74db69b7d7fe/resourceGroups/rg-fiap/providers/Microsoft.Storage/storageAccounts/safiapterraform"
  to = module.azure.azurerm_storage_account.this
}


import {
  id = "https://safiapterraform.blob.core.windows.net/terraform-state"
  to = module.azure.azurerm_storage_container.this
}

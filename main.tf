
terraform {

  required_version = "~>1.8"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  backend "local" {
    path = "./terraform.tfstate"
  }

}

provider "github" {
  owner = "renata-gotler" # Troque pela sua conta pessoal ou organização
}


# Adicionar um usuário para a organização
# resource "github_membership" "membership_for_user_x" {
   # ...
# }

import {
  id = "ai_product_template"
  to = module.github.github_repository.this["ai_product_template"]
}

import {
  id = "ai_project_example"
  to = module.github.github_repository.this["ai_project_example"]
}

import {
  id = "asl-ml-immersion"
  to = module.github.github_repository.this["asl-ml-immersion"]
}

import {
  id = "studies"
  to = module.github.github_repository.this["studies"]
}
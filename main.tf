
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

import {
  id = "ai_product_template"
  to = github_repository.this["ai_product_template"]
}

import {
  id = "asl-ml-immersion"
  to = github_repository.this["asl-ml-immersion"]
}

import {
  id = "studies"
  to = github_repository.this["studies"]
}
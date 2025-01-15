
terraform {

  required_version = "~>1.8"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = "renata-gotler" # Troque pela sua conta pessoal ou organização
}

# Adicionar um usuário para a organização
# resource "github_membership" "membership_for_user_x" {
   # ...
# }
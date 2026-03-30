

locals {

  organization_name = "renata-gotler"

  repo_list = [
    { name = "ai_product_template", description = "Template repository for new AI projects", status_checks_main = ["lint", "test"] },
    { name = "ai_project_example", template_repo = "ai_product_template", status_checks_main = ["lint", "test"] },
{ name = "ai_test", template_repo = "ai_product_template", status_checks_main = ["lint", "test"] },
    { name = "studies", description = "Template repository for new AI projects" },
    { name = "asl-ml-immersion", description = "Template repository for new AI projects" },
    { name = "terraform", owning_teams = ["Terraform-Admins"], status_checks_main = ["plan / plan"] },
    { name = "marketing_recommender", template_repo = "ai_product_template", owning_teams = ["Terraform-Admins"], status_checks_main = ["lint", "test"], description = "Project that aims to generate a recommendation system for marketing strategy." }
  ]

  repo_list_foreach = { for repo in local.repo_list : repo.name => repo }

}


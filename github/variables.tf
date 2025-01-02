

variable "team" {
  type = string
}

variable "group" {
  type = string
}

locals {

  organization_name = "renata-gotler"

  repo_list = [
    { name = "ai_product_template", owning_teams = ["ArtificialIntelligence"], description = "Template repository for new AI projects", status_checks_main = ["lint", "test"] },
    { name = "ai_project_example", owning_teams = ["ArtificialIntelligence"], template_repo = "ai_product_template", status_checks_main = ["lint", "test"] },
    { name = "studies", owning_teams = ["ArtificialIntelligence"], description = "Template repository for new AI projects" },
    { name = "asl-ml-immersion", owning_teams = ["ArtificialIntelligence"], description = "Template repository for new AI projects" },
]

  repo_list_foreach = { for repo in local.repo_list : repo.name => repo }

  departments = {
    "technology" = {
      name = "Technology",
      "job_titles" = {
        "sr_ml_engineer"     = "Senior ML Engineer",
      }
    }
  }

  users = [{
      given_name      = "Renata"
      surname         = "Gotler"
      github_username = "renata-gotler"
      email           = "renata.gotler@gmail.com"
      department      = local.user_defaults.departments.technology.name
      job_title       = local.user_defaults.departments.technology.job_titles.sr_ml_engineer
      _group_membership = [
        "ArtificialIntelligence",
        "DataEngineering",
        "PyPI-Admins",
        "GitHub-Admins",
        "Terraform-Admins"]
      }]

  team_list = [
    { name : "ai", group : "ArtificialIntelligence"},
    { name : "de", group : "DataEngineering"}
  ]

  teams_for_each = { for team in local.team_list : team.name => team }
}


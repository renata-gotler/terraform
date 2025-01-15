
resource "github_repository" "this" {
  for_each    = local.repo_list_foreach
  name        = each.key
  description = contains(keys(each.value), "description") ? "${each.value.description} - Auto-generated via Terraform" : "Auto-generated via Terraform"

  visibility = "public"

  has_downloads   = false
  has_discussions = false
  has_issues      = false
  has_projects    = false
  has_wiki        = false

  is_template         = strcontains(each.key, "template")
  allow_update_branch = strcontains(each.key, "template")

  dynamic "template" {
    for_each = contains(keys(each.value), "template_repo") ? toset([each.value.template_repo]) : []
    content {
      owner                = local.organization_name
      repository           = template.key
      include_all_branches = false
    }
  }
}

resource "github_repository_collaborators" "this" {
  for_each   = local.repo_list_foreach
  repository = github_repository.this[each.key].name

  # read < triage < push < maintain < admin
  team {
    team_id    = lower("GitHub-Admins")
    permission = "admin"
  }
  dynamic "team" {
    for_each = each.value.owning_teams
    content {
      team_id    = lower(team.value)
      permission = "maintain"
    }
  }
  dynamic "team" {
    for_each = lookup(each.value, "user_teams", ["GitHub-Users"])
    content {
      team_id    = lower(team.value)
      permission = "push"
    }
  }
}

resource "github_branch" "dev" {
  for_each   = local.repo_list_foreach
  repository = each.key
  branch     = "dev"
}

resource "github_branch_protection" "main" {
  for_each      = local.repo_list_foreach
  repository_id = github_repository.this[each.key].node_id

  pattern                         = "main"
  enforce_admins                  = false
  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = false

  required_status_checks {
    strict   = true
    contexts = lookup(each.value, "status_checks_main", [])
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    require_code_owner_reviews      = true
    require_last_push_approval      = true
    required_approving_review_count = 1
    restrict_dismissals             = true

    dismissal_restrictions = toset([for team in each.value.owning_teams : lower("${local.organization_name}/${team}")])
    pull_request_bypassers = toset([for team in each.value.owning_teams : lower("${local.organization_name}/${team}")])
  }
}

resource "github_branch_protection" "dev" {
  for_each      = local.repo_list_foreach
  repository_id = github_repository.this[each.key].node_id

  pattern                         = "dev"
  enforce_admins                  = false
  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = false

  required_status_checks {
    strict   = true
    contexts = lookup(each.value, "status_checks_dev", [])
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    require_code_owner_reviews      = true
    require_last_push_approval      = true
    required_approving_review_count = 1
    restrict_dismissals             = true

    dismissal_restrictions = toset([for team in each.value.owning_teams : lower("${local.organization_name}/${team}")])
    pull_request_bypassers = toset([for team in each.value.owning_teams : lower("${local.organization_name}/${team}")])
  }
}
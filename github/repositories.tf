
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

  auto_init = true

  dynamic "template" {
    for_each = contains(keys(each.value), "template_repo") ? toset([each.value.template_repo]) : []
    content {
      owner                = local.organization_name
      repository           = template.key
      include_all_branches = false
    }
  }
}

resource "github_branch" "dev" {
  for_each   = local.repo_list_foreach
  repository = github_repository.this[each.key].name
  branch     = "dev"
}

resource "github_branch_protection" "main" {
  for_each      = local.repo_list_foreach
  repository_id = github_repository.this[each.key].node_id

  pattern                         = "main"
  enforce_admins                  = false
  allows_deletions                = false
  allows_force_pushes             = false
  require_conversation_resolution = true

  required_status_checks {
    strict   = true
    contexts = lookup(each.value, "status_checks_main", [])
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    require_code_owner_reviews      = true
    require_last_push_approval      = true
    required_approving_review_count = 1
    restrict_dismissals             = false
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
    restrict_dismissals             = false
  }
}
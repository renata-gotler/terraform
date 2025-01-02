# create teams on github and assign membership
resource "github_team" "teams" {
  for_each = { for group in local.teams_for_each : group.name => group if lookup(group, "_github", false) }

  name        = each.key
  description = "Auto-generated via Terraform"
  privacy     = "secret"
}

resource "github_team_members" "team_members" {
  for_each = { for group in local.teams_for_each : group.name => group if lookup(group, "_github", false) }
  team_id  = github_team.teams[each.key].id

  dynamic "members" {
    for_each = {
      for user in local.users : user.github_username => user
      if(contains(user._group_membership, each.value.name) || lookup(each.value, "_all_users", false)) && lookup(user, "github_username", null) != null
    }

    content {
      username = members.value.github_username
      role     = "maintainer" # maintainer, member
    }
  }
}
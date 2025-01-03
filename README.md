<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch.development](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/branch) | resource |
| [github_branch_protection.dev](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/branch_protection) | resource |
| [github_branch_protection.main](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.this](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborators.this](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_collaborators) | resource |
| [github_team.teams](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team) | resource |
| [github_team_members.team_members](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team_members) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group"></a> [group](#input\_group) | n/a | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
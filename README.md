# terraform-vault-add-permission-group

Use-case module that creates a custom ACL policy for any Vault path and grants it to one principal entity via identity group membership.

## Layer

Use-case.

## Prerequisites

- Principal module output `entity_id`

## Inputs

| Name | Type | Description |
|---|---|---|
| `cluster_name` | `string` | Cluster identifier, regex validated |
| `principal_name` | `string` | Principal identifier, regex validated |
| `usecase_name` | `string` | Use-case identifier, regex validated |
| `entity_id` | `string` | Principal entity ID |
| `secret_path` | `string` | Vault path expression |
| `capability_read` | `bool` | Read capability flag, default `true` |
| `capability_create` | `bool` | Create capability flag, default `false` |
| `capability_update` | `bool` | Update capability flag, default `false` |
| `capability_delete` | `bool` | Delete capability flag, default `false` |
| `capability_list` | `bool` | List capability flag, default `true` |
| `capability_patch` | `bool` | Patch capability flag, default `false` |
| `capability_sudo` | `bool` | Sudo capability flag, default `false` |

## Outputs

| Name | Description |
|---|---|
| `policy_name` | Custom ACL policy name |
| `group_name` | Identity group name |

## No-code notes

- Capability booleans map directly to no-code checkboxes.
- At least one capability must be enabled.
- This module renders no YAML and only creates policy plus identity group resources.

## Registry usage

```hcl
module "add_permission_group" {
  source  = "app.terraform.io/<org>/add-permission-group/vault"
  version = "~> 0.1"

  cluster_name      = "ocp-prod-eu"
  principal_name    = "payments"
  usecase_name      = "audit-access"
  entity_id         = "11111111-2222-3333-4444-555555555555"
  secret_path       = "secret/data/payments/audit/*"
  capability_read   = true
  capability_list   = true
  capability_create = false
}
```

This module renders no YAML. It only creates policy and group resources.

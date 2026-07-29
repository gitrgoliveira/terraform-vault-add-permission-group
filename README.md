# terraform-vault-add-permission-group

Use-case module that creates a custom ACL policy for any Vault path and grants it to one workload entity via identity group membership.

## Layer

Use-case.

## Prerequisites

- The workload module must be applied first so the entity `<cluster_name>-<workload_name>` exists in Vault.

## Inputs

| Name | Type | Description |
|---|---|---|
| `cluster_name` | `string` | Cluster identifier, regex validated |
| `workload_name` | `string` | Workload identifier, regex validated |
| `usecase_name` | `string` | Use-case identifier, regex validated |
| `secret_path` | `string` | Vault path expression |
| `capability_read` | `bool` | Read capability flag, default `true` |
| `capability_create` | `bool` | Create capability flag, default `false` |
| `capability_update` | `bool` | Update capability flag, default `false` |
| `capability_delete` | `bool` | Delete capability flag, default `false` |
| `capability_list` | `bool` | List capability flag, default `true` |
| `capability_patch` | `bool` | Patch capability flag, default `false` |
| `capability_sudo` | `bool` | Sudo capability flag, default `false`. See warning under the table. |

> **Warning — `capability_sudo`:** sudo overrides deny policies and is the only way to reach root-protected Vault paths (seal, rekey, audit devices). The module rejects `capability_sudo = true` when `secret_path` starts with `sys/` or `auth/`; even on other paths, never combine it with broad wildcards, and require out-of-band platform-team approval before granting it through a self-service flow.

## Outputs

| Name | Description |
|---|---|
| `policy_name` | Custom ACL policy name |
| `group_name` | Identity group name |

## No-code notes

- Capability booleans map directly to no-code checkboxes.
- At least one capability must be enabled.
- This module renders no YAML and only creates policy plus identity group resources.

## No-code provisioning

This module is no-code enabled in the `hc-ric-demo` private registry (pinned to `0.2.0`). Click **Provision workspace**, pick a project and workspace name, then complete the form. Capability flags render as checkboxes; at least one must be enabled.

Form fields:

| Field | Required | Notes |
|---|---|---|
| `cluster_name` | yes | Cluster identifier |
| `workload_name` | yes | Workload identifier |
| `usecase_name` | yes | Use-case identifier |
| `secret_path` | yes | Vault path expression |
| `capability_*` | no | Read/list default true; others default false |

## Registry usage

```hcl
module "add_permission_group" {
  source  = "app.terraform.io/<org>/add-permission-group/vault"
  version = "~> 0.2.0"

  cluster_name      = "ocp-prod-eu"
  workload_name     = "payments"
  usecase_name      = "audit-access"
  secret_path       = "secret/data/payments/audit/*"
  capability_read   = true
  capability_list   = true
  capability_create = false
}
```

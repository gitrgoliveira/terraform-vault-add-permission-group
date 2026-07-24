provider "vault" {
  skip_child_token = true
}

locals {
  capabilities = compact([
    var.capability_read ? "read" : "",
    var.capability_create ? "create" : "",
    var.capability_update ? "update" : "",
    var.capability_delete ? "delete" : "",
    var.capability_list ? "list" : "",
    var.capability_patch ? "patch" : "",
    var.capability_sudo ? "sudo" : "",
  ])

  group_name  = "${var.cluster_name}-${var.workload_name}-${var.usecase_name}-perm"
  policy_name = "${var.cluster_name}-${var.workload_name}-${var.usecase_name}-perm-acl"
}

data "vault_identity_entity" "workload" {
  entity_name = "${var.cluster_name}-${var.workload_name}"
}

resource "vault_policy" "this" {
  name = local.policy_name

  policy = <<-EOT
path "${var.secret_path}" {
  capabilities = ${jsonencode(local.capabilities)}
}
EOT
}

resource "vault_identity_group" "this" {
  name              = local.group_name
  type              = "internal"
  policies          = [vault_policy.this.name]
  member_entity_ids = [data.vault_identity_entity.workload.id]
}

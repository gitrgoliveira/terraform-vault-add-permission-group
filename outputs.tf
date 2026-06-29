output "group_name" {
  description = "Identity group name granting the custom policy."
  value       = vault_identity_group.this.name
}

output "policy_name" {
  description = "Custom ACL policy name."
  value       = vault_policy.this.name
}

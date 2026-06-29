terraform {
  required_version = ">= 1.9"
}

locals {
  principal_cluster_name = "ocp-prod-eu"
  principal_entity_id    = "11111111-2222-3333-4444-555555555555"
  principal_name         = "payments"
}

module "add_permission_group" {
  source = "../../"

  capability_create = var.capability_create
  capability_list   = var.capability_list
  capability_read   = var.capability_read
  cluster_name      = local.principal_cluster_name
  entity_id         = local.principal_entity_id
  principal_name    = local.principal_name
  secret_path       = var.secret_path
  usecase_name      = var.usecase_name
}

variable "capability_create" {
  type        = bool
  description = "Whether to grant create."
  default     = false
}

variable "capability_list" {
  type        = bool
  description = "Whether to grant list."
  default     = true
}

variable "capability_read" {
  type        = bool
  description = "Whether to grant read."
  default     = true
}

variable "secret_path" {
  type        = string
  description = "Vault path to grant access to."
}

variable "usecase_name" {
  type        = string
  description = "Use-case identifier."
}

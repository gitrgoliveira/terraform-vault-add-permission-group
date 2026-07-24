variable "capability_create" {
  type        = bool
  description = "Whether to grant create capability."
  default     = false

  validation {
    condition = (
      var.capability_read ||
      var.capability_create ||
      var.capability_update ||
      var.capability_delete ||
      var.capability_list ||
      var.capability_patch ||
      var.capability_sudo
    )
    error_message = "At least one capability_* variable must be true."
  }
}

variable "capability_delete" {
  type        = bool
  description = "Whether to grant delete capability."
  default     = false
}

variable "capability_list" {
  type        = bool
  description = "Whether to grant list capability."
  default     = true
}

variable "capability_patch" {
  type        = bool
  description = "Whether to grant patch capability."
  default     = false
}

variable "capability_read" {
  type        = bool
  description = "Whether to grant read capability."
  default     = true
}

variable "capability_sudo" {
  type        = bool
  description = "Whether to grant sudo capability."
  default     = false
}

variable "capability_update" {
  type        = bool
  description = "Whether to grant update capability."
  default     = false
}

variable "cluster_name" {
  type        = string
  description = "Cluster identifier used in policy and group naming."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.cluster_name))
    error_message = "cluster_name must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
  }
}

variable "secret_path" {
  type        = string
  description = "Vault path expression to grant capabilities on."

  validation {
    condition     = can(regex("^[A-Za-z0-9_./*+-]+$", var.secret_path))
    error_message = "secret_path may only contain letters, digits, and _ . / * + - (no quotes, braces, backslashes, or whitespace)."
  }
}

variable "usecase_name" {
  type        = string
  description = "Use-case identifier used in policy and group naming."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.usecase_name))
    error_message = "usecase_name must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
  }
}

variable "workload_name" {
  type        = string
  description = "Workload identifier used in policy and group naming."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.workload_name))
    error_message = "workload_name must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
  }
}

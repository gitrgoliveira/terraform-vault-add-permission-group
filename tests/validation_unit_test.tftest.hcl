mock_provider "vault" {}

run "all_capabilities_false_fails_validation" {
  command = plan

  variables {
    capability_create = false
    capability_delete = false
    capability_list   = false
    capability_patch  = false
    capability_read   = false
    capability_sudo   = false
    capability_update = false

    cluster_name  = "dev-cluster"
    secret_path   = "kv/dev-cluster/apps/payments/*"
    usecase_name  = "payments"
    workload_name = "apps"
  }

  expect_failures = [
    var.capability_create,
  ]
}

run "invalid_usecase_name_fails_validation" {
  command = plan

  variables {
    cluster_name  = "dev-cluster"
    secret_path   = "kv/dev-cluster/apps/payments/*"
    usecase_name  = "INVALID_NAME"
    workload_name = "apps"
  }

  expect_failures = [
    var.usecase_name,
  ]
}

run "injection_in_secret_path_fails_validation" {
  command = plan

  variables {
    cluster_name = "dev-cluster"
    # Breakout chars (quote, brace, space) must be rejected so secret_path
    # cannot terminate the policy path block and inject extra stanzas.
    secret_path   = "bad\" {x}"
    usecase_name  = "payments"
    workload_name = "apps"
  }

  expect_failures = [
    var.secret_path,
  ]
}

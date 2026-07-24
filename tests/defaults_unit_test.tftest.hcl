mock_provider "vault" {}

run "defaults_plan_succeeds" {
  command = plan

  variables {
    cluster_name  = "dev-cluster"
    secret_path   = "kv/dev-cluster/apps/payments/*"
    usecase_name  = "payments"
    workload_name = "apps"
  }

  assert {
    condition     = output.policy_name == "dev-cluster-apps-payments-perm-acl"
    error_message = "policy_name should match naming convention."
  }

  assert {
    condition     = output.group_name == "dev-cluster-apps-payments-perm"
    error_message = "group_name should match naming convention."
  }
}

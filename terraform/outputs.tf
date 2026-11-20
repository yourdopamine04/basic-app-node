output "workload_identity_provider" {
  value = google_iam_workload_identity_pool_provider.github.name
}

output "github_actions_service_account" {
  value = google_service_account.github_actions.email
}
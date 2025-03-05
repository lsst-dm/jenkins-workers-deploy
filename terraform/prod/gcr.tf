resource "google_artifact_registry_repository" "knative_test" {
  format                 = "DOCKER"
  repository_id          = "knative-test"
  cleanup_policy_dry_run = true
  project                = "prompt-proto"
  docker_config {
    immutable_tags = false
  }
  vulnerability_scanning_config {
    enablement_config       = null
    enablement_state_reason = null
  }

}

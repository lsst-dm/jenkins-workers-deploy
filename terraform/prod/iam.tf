
resource "google_service_account" "eups_dev"{
  account_id = "eups-dev"
  description  = "Owner of development eups.lsst.cloud bucket" 
  display_name = "eups-dev"
}
resource "google_service_account" "gcr_jenkins_backup" {
  account_id = "gcr-jenkins-backup"
  description  = "Image container registry for Jenkins"
  display_name = "gcr-jenkins-backup"
}
resource "google_service_account" "jenkins_secrets" {
  account_id = "jenkins-secrets"
  description  = "Manage secrets for Jenkins"
  display_name = "jenkins-secrets" 
}
resource "google_service_account" "jenkins_dev" {
  account_id = "jenkins-dev"
  description  = "Write to dev artifact registry"
  display_name = "jenkins-dev" 
}
resource "google_service_account" "prompt-build" {
  account_id = "prompt-build"
  description  = "Account to push container artifacts"
  display_name = "prompt-build" 
}
resource "google_service_account" "prompt-image-upload" {
  account_id = "prompt-image-upload"
  description  = "Uploads images to main bucket"
  display_name = "prompt-image-upload" 
}
resource "google_service_account" "usdf-pp-docker-pull" {
  account_id = "usdf-pp-docker-pull"
  description  = "usdf prompt processing docker pull secret"
  display_name = "usdf-pp-docker-pull" 
}
resource "google_service_account" "vault-google-oauth" {
  account_id = "vault-google-oauth"
  description  = "Service account used for google oauth group mapping"
  display_name = "vault-google-oauth" 
}
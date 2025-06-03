resource "google_service_account" "eups" {
  account_id = "eups-prod"
  display_name = "eups-prod"
  description  = "Owner of production eups.lsst.cloud bucket" 
}

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

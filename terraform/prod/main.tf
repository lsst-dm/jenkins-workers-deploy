provider "google" {
  project = "prompt-proto"
  region  = "us-central1"
}
terraform {
  backend "gcs" {
    bucket  = "jenkins-tf-state-prod"
    prefix  = "terraform/state"
  }
}

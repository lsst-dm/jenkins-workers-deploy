terraform {
  required_version = ">= 1.11.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>7.12.0"
    }
  }
}

provider "google" {
  project = "prompt-proto"
  region  = "us-central1"
}
terraform {
  backend "gcs" {
    bucket = "jenkins-tf-state-prod"
    prefix = "terraform/state"
  }
}

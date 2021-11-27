// Configure the Google Cloud provider
provider "google" {
  project = "decibelduck"
  region  = "us-west1"
}

terraform {
  backend "gcs" {
    prefix                      = "dev"
    bucket                      = "tfstate1.decibelduck.com"
  }
}

locals {
  extra_label = length(var.extra_label) > 0 ? "-${var.extra_label}" : ""
}

resource "google_project" "developer" {
  name       = "dev-${var.env_label}${local.extra_label}"
  project_id = "dev-${var.env_label}${local.extra_label}"
}

resource "google_storage_bucket" "tfstate_env_bucket" {
  name     = "${var.env_label}-${var.region}${local.extra_label}"
  location = var.region
  project  = google_project.developer.project_id
  versioning {
    enabled = true
  }
  ##  gsutil mb --pap enforced -l us-west1 -b on $bucket ??
}

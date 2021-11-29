provider "google" {
  project = "decibelduck-internal"
  region  = "us-west1"
}

resource "google_project_service" "secretmanager-api" {
  service = "secretmanager.googleapis.com"
}

resource "time_sleep" "secretmanager-api-enabling" {
  depends_on = [
    google_project_service.secretmanager-api
  ]

  create_duration = "3m"
}

resource "google_secret_manager_secret" "secret" {
  depends_on = [
    time_sleep.secretmanager-api-enabling
  ]
  secret_id = var.id
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.data
}
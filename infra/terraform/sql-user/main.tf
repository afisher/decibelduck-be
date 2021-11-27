provider "google" {
  project = "decibelduck-internal"
  region  = "us-west1"
}

resource "random_string" "user_password" {
  length           = 16
  special          = true
  override_special = "/+"
}

resource "google_sql_user" "user" {
  name     = var.name
  instance = var.instance_name
  password = random_string.user_password.result
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

resource "google_secret_manager_secret" "user-password" {
  depends_on = [
    time_sleep.secretmanager-api-enabling
  ]
  secret_id = "sqluser__${replace(google_sql_user.user.instance, "-", "_")}__${google_sql_user.user.name}__password"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "user-password" {
  secret      = google_secret_manager_secret.user-password.id
  secret_data = random_string.user_password.result
}
output "id" {
    value = google_secret_manager_secret.secret.secret_id
}

output "secret" {
    value = google_secret_manager_secret_version.secret.secret_data
}
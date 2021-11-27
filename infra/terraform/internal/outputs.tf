output "database_info" {
    sensitive = true
    value = {
        host = google_sql_database_instance.main.public_ip_address
        user = google_sql_user.ducky.name
        password = google_sql_user.ducky.password
        connect = "postgres://${google_sql_user.ducky.name}:${google_sql_user.ducky.password}@${google_sql_database_instance.main.public_ip_address}/postgres"
    }
}
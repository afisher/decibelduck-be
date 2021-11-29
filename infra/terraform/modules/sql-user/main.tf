provider "google" {
  project = var.project
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

module "user_password" {
  source = "../secret"
  project = var.project
  id = "sqluser__${replace(google_sql_user.user.instance, "-", "_")}__${google_sql_user.user.name}__password"
  data = random_string.user_password.result
}

// Configure the Google Cloud provider
provider "google" {
  project = "decibelduck-internal"
  region  = "us-west1"
}

terraform {
  backend "gcs" {
    prefix                      = "dev"
    bucket                      = "tfstate1-decibelduck-com"
  }
}

locals {
    cidrs_permitted = ["75.164.153.215/32"]
}

resource "google_dns_managed_zone" "example-zone" {
    name        = "decibelduck-com"
    dns_name    = "decibelduck.com."
    description = "decibelduck.com public"
}

resource "google_sql_database_instance" "main" {
    name             = "main-instance"
    database_version = "POSTGRES_13"
    region           = "us-west1"

    settings {
        tier = var.db_instance_tier

        ip_configuration {
            ipv4_enabled = true
            dynamic "authorized_networks" {
              for_each = local.cidrs_permitted
              iterator = cidr
              content {
                value = cidr.value
              }
            }
        }
    }
}

# resource "google_project_service" "compute-api" {
#     service = "compute.googleapis.com"
# }

resource "random_string" "ducky_password" {
  length           = 16
  special          = true
  override_special = "/+"
}

resource "google_sql_user" "ducky" {
  name     = "ducky"
  instance = google_sql_database_instance.main.name
  password = random_string.ducky_password.result
}
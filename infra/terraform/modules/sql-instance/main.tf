provider "google" {
  project = var.project
  region  = "us-west1"
}

locals {
  # this is a temporary hack until we work out database connectors
  cidrs_permitted = ["75.164.153.215/32"]
  ipv4_enabled = true
}

resource "google_sql_database_instance" "instance" {
  name             = var.name
  database_version = "POSTGRES_13"
  region           = var.region

  settings {
    tier = var.instance_tier

    ip_configuration {
      ipv4_enabled = local.ipv4_enabled
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
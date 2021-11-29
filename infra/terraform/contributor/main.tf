provider "google" {
  project = "decibelduck-internal"
  region  = "us-west1"
}

locals {
    slug = "${var.contributor}-${var.extra-label}"
    internal-project = "decibelduck-internal"
}

resource "google_project" "contributor-project" {
    name = "decibelduck-${local.slug}"
    project_id = "decibelduck-${local.slug}"
}

# resource "google_compute_network" "network" {
# 
# }

data "google_sql_database_instance" "instance" {
    name = var.instance_name
    project = local.internal-project
}

resource "google_sql_database" "database" {
  name     = local.slug
  instance = var.instance
}

module "contributor-user" {
    source = "../sql-user"
    name = var.contributor
    instance_name = google_sql_database.database.instance_name
}

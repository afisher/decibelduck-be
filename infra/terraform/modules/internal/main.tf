provider "google" {
  project = var.project
  region  = "us-west1"
}

resource "google_dns_managed_zone" "decibelduck-com" {
  name        = "decibelduck-com"
  dns_name    = "decibelduck.com."
  description = "decibelduck.com public"
}

module "dev-instance" {
  source = "../sql-instance"
  project = var.project
  name = "dev-instance"
}

module "ducky-user" {
  source = "../sql-user"
  project = var.project
  name = "ducky"
  instance_name = module.dev-instance.instance_name
}

# module "prod-instance" {
#   source = "../sql-instance"
#   project = var.project
#   name = "prod-instance"
# }
#
#
# module "pucky-user" {
#   source = "../sql-user"
#   project = var.project
#   name = "pucky"
#   instance_name = module.prod-instance.instance_name
# }
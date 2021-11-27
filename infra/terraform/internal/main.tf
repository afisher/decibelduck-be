provider "google" {
  project = "decibelduck-internal"
  region  = "us-west1"
}

terraform {
  backend "gcs" {
    prefix = "internal"
    bucket = "tfstate1-decibelduck-com"
  }
}

resource "google_dns_managed_zone" "decibelduck-com" {
  name        = "decibelduck-com"
  dns_name    = "decibelduck.com."
  description = "decibelduck.com public"
}

module "dev-instance" {
  source = "../sql-instance"
  name = "dev-instance"
}

module "ducky-user" {
  source = "../sql-user"
  name = "ducky"
  instance_name = module.dev-instance.instance_name
}

# module "prod-instance" {
#   source = "../sql-instance"
#   name = "prod-instance"
# }
#
#
# module "pucky-user" {
#   source = "../sql-user"
#   name = "pucky"
#   instance_name = module.prod-instance.instance_name
# }
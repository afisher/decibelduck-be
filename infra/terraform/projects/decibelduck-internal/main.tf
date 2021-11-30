terraform {
  backend "gcs" {
    prefix = "internal"
    bucket = "tfstate-decibelduck-com"
  }
}

module "decibelduck-internal" {
    source = "../../modules/internal"
    project = "decibelduck-internal"
}
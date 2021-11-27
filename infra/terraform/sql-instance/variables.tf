variable "name" {
    description = "name of the instance"
}

variable "region" {
  default = "us-west1"
}

variable "instance_tier" {
  description = "tier (size, for billing) of sql instance"
  default = "db-f1-micro"
}
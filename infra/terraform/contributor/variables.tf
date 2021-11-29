variable "contributor" {
  type        = string
  description = "The short username of a person (developer) working on this project, such as 'cdodt'"

  validation {
    condition     = can(regex("^[a-zA-Z0-9]+$", var.contributor))
    error_message = "Var contributor can contain only letters and digits."
  }
}

variable "extra-label" {
  type        = string
  description = "Any additional label the developer wants to add to distinguish this environment"
  default = "1"

  validation {
    condition     = can(regex("^[a-zA-Z0-9]+$", var.extra-label))
    error_message = "Var extra-label can contain only letters and digits."
  }
}

variable "instance_name" {
  description = "A SQL database instance"
}
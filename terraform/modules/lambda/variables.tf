################ Variables ################
variable "application_name" {
  description = "Name of the application."
  type        = string
  default     = "example"
}

variable "environment" {
  description = "Name of the environment."
  type        = string
  default     = "dev"

  validation {
    condition     = length(var.environment) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.environment)) == 0
    error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
  }
}

variable "src_path" {
  description = "Absolute path to the lambda function code."
}

variable "lambda_role" {}
variable "subnet_ids" {}
variable "load_balancer_sg" {}
variable "lambda_log_level" {}
variable "secret_name" {}
variable "queue" {}
variable "bucket" {}

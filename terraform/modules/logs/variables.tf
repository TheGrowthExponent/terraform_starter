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

variable "region" {
  description = "Region to deploy resources."
  type        = string
  default     = "ap-southeast-2"
}

## Enable/Disable ##
variable "create_aws_cloudwatch_dashboard" {
  description = "Specify whether to create the dashboard or not"
  type        = bool
  default     = false
}

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

variable "grafana_role_arn" {
  description = "The ARN of the role to assume for Grafana"
  type        = string
}

# variable "sg_ids" {
#   description = "The Security Group IDs"
#   type        = list(string)
# }
#
# variable "subnet_ids" {
#   description = "The Subnet IDs"
#   type        = list(string)
# }

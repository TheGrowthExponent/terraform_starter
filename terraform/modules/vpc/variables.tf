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

### Add if importing existing VPC ###
# variable "vpc_id" {
#   description = "The VPC Id"
#   type        = string
# }
#
# variable "public_subnets" {
#   description = "The Public Subnet IDs"
#   type        = list(string)
# }
#
# variable "private_subnets" {
#   description = "The Private Subnet IDs"
#   type        = list(string)
# }

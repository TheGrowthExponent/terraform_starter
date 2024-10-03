################ Variables ################
# variable "application_name" {
#   description = "Name of the application."
#   type        = string
#   default     = "example"
# }
#
# variable "environment" {
#   description = "Name of the environment."
#   type        = string
#   default     = "dev"
#
#   validation {
#     condition     = length(var.environment) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.environment)) == 0
#     error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
#   }
# }

variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID"
  type        = string
}

variable "host_name" {
  description = "The Route53 Host Name"
  type        = string
}

# variable "cname_destination_url" {
#   description = "The CNAME destination URL"
#   type        = string
# }

variable "load_balancer" {
  description = "The Load Balancer"
  type        = map(string)
}

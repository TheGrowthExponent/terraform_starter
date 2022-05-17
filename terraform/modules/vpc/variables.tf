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

variable "vpc_id" {
  description = "AWS region"
  type        = string

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "The vpc_id value must be a valid VPC id, starting with \"vpc-\"."
  }
}

variable "subnets_public" {
  description = "AWS public subnets"
}

variable "subnets_private" {
  description = "AWS private subnets"
}

variable "tags" {
  description = "Shared tags."
}
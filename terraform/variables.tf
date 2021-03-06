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

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {}
}

variable "profile" {
  description = "IAM Profile"
  type        = string
  sensitive   = true
}

variable "region" {
  default     = "ap-southeast-2"
  type        = string
  description = "The region you want to deploy the infrastructure in"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.account_id) == 12 && length(regexall("[^0-9]", var.account_id)) == 0
    error_message = "The account number must be 12 characters, and only contain numbers."
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

variable "hosted_zone_id" {
  type        = string
  description = "The id of the hosted zone of the Route 53 domain you want to use"
}

variable "host_name" {
  type        = string
  description = "The Route 53 domain host name you want to use"
}

variable "notification_recipients" {
  description = "Email address list of notification recipients."
}
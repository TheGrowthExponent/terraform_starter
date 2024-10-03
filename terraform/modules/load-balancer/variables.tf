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

variable "load_balancer_sg" {
  description = "The Security Group ID for the Load Balancer"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "The VPC Id"
}

variable "private_subnets" {
  description = "The Private Subnet IDs"
  type        = list(string)
}

variable "certificate" {
  description = "The ARN of the certificate"
  type        = string
}

variable "authorization_endpoint" {
  description = "Azure AAD authorization endpoint"
  type        = string
}

variable "client_id" {
  description = "Azure AAD client id"
  type        = string
}

variable "client_secret" {
  description = "Azure AAD client secret"
  type        = string
}

variable "issuer" {
  description = "Azure AAD issuer"
  type        = string
}

variable "token_endpoint" {
  description = "Azure AAD token endpoint"
  type        = string
}

variable "user_info_endpoint" {
  description = "Azure AAD user info endpoint"
  type        = string
}

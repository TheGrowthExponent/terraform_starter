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

variable "account_id" {
  description = "AWS Account ID"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.account_id) == 12 && length(regexall("[^0-9]", var.account_id)) == 0
    error_message = "The account number must be 12 characters, and only contain numbers."
  }
}

# variable "api_gw_disable_resource_creation" {
#   description = "Specify whether to create or not the default /api/messages path or stop at /api"
#   type        = bool
# }

variable "api_gw_endpoint_configuration_type" {
  description = "Specify the type of endpoint for API GW to be setup as. [EDGE, REGIONAL, PRIVATE]. Defaults to EDGE"
  type        = string
}

# variable "stage_name" {
#   description = "The stage name for the API deployment"
#   type        = string
#   default     = "dev"
# }

# variable "method" {
#   description = "The HTTP method"
#   type        = string
#   default     = "POST"
# }

# variable "dependency_list" {
#   description = "Deployment dependency list"
#   type        = list(string)
# }

variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID"
  type        = string
}

variable "host_name" {
  description = "The Route53 Host Name"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN"
  type        = string
}

# variable "apigw_role" {
#   description = "The ARN of the role"
#   type        = string
# }

#variable "lambda_authorizer" {
#    description = "The ARN of the lambda authorizer"
#    type        = string
#    }

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

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

# variable "profile" {
#   description = "IAM Profile"
#   type        = string
#   sensitive   = true
# }
#
# variable "aws_external_role_id" {
#   description = "AWS IAM External Role ID"
#   type        = string
#   sensitive   = true
# }

# variable "vpc_id" {
#   description = "AWS region"
#   type        = string
#
#   validation {
#     # regex(...) fails if it cannot find a match
#     condition     = can(regex("^vpc-", var.vpc_id))
#     error_message = "The vpc_id value must be a valid VPC id, starting with \"vpc-\"."
#   }
# }

# variable "public_subnets" {
#   description = "AWS public subnets"
# }
#
# variable "private_subnets" {
#   description = "AWS private subnets"
# }

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
  type        = list(string)
}

# variable "aad_group_name" {
#   description = "Azure AAD group name"
#   type        = string
# }

# variable "tenant_id" {
#   description = "Azure AAD tenant ID"
#   type        = string
# }

variable "authorization_endpoint" {
  description = "Azure AAD authorization endpoint"
  type        = string
}

variable "client_id" {
  description = "Azure AAD client ID"
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

#API Gateway Setup
# variable "api_gw_method" {
#   description = "API Gateway method (GET,POST...)"
#   type        = string
#   default     = "POST"
# }

# variable "api_gw_dependency_list" {
#   description = "List of aws_api_gateway_integration* that require aws_api_gateway_deployment dependency"
#   type        = list(string)
#   default     = []
# }

# variable "api_gw_disable_resource_creation" {
#   description = "Specify whether to create or not the default /api/messages path or stop at /api"
#   type        = string
#   default     = "false"
# }

variable "api_gw_endpoint_configuration_type" {
  description = "Specify the type of endpoint for API GW to be setup as. [EDGE, REGIONAL, PRIVATE]. Defaults to EDGE"
  type        = string
  default     = "EDGE"
}

variable "create_api-gateway_module" {
  description = "Specify whether to create the api-gateway module or not"
  type        = string
  default     = "0"
}

## Enable/Disable Modules ##
variable "create_auto_scaling_module" {
  description = "Specify whether to create the auto_scaling module or not"
  type        = string
  default     = "0"
}

variable "create_lambda_module" {
  description = "Specify whether to create the lambda module or not"
  type        = string
  default     = "0"
}

variable "create_postgres_module" {
  description = "Specify whether to create the postgres module or not"
  type        = string
  default     = "0"
}

variable "create_batch_module" {
  description = "Specify whether to create the batch module or not"
  type        = string
  default     = "0"
}

variable "create_ecs_module" {
  description = "Specify whether to create the ecs module or not"
  type        = string
  default     = "0"
}

variable "create_ec2_instance" {
  description = "Specify whether to create the ec2 instance or not"
  type        = string
  default     = "0"
}

variable "batch_memory" {
  description = "The Memory of ECS Task"
  type        = string
  default     = "512"
}

variable "batch_fargate_vcpu" {
  description = "The vCPU of ECS Task"
  type        = string
  default     = "0.25"
}

variable "batch_ec2_vcpu" {
  description = "The vCPU of ECS Task"
  type        = string
  default     = "1"
}

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

variable "db_name" {
  description = "Name of RDS DB instance"
  type        = string
}

variable "instance_class" {
  description = "The instance type to use. `db.serverless` is only available for Aurora."
  type        = string
  default     = "db.serverless"
}

variable "engine" {
  description = "The database engine to use."
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_mode" {
  description = "The database engine mode to use."
  type        = string
  default     = "provisioned"
}

variable "engine_version" {
  description = "The version of the database engine to use."
  type        = string
  default     = "16"
}

variable "db_admin_user" {
  description = "Backend database admin username. This variable should be retrieved from an [environment variable](https://www.terraform.io/cli/config/environment-variables#tf_var_name) or a secure secret store like [AWS Secrets Manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret). DO NOT HARDCODE."
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  type        = string
  description = "Name of subnet group for RDS"
}

variable "subnet_ids" {
  description = "Subnets to allow access to RDS"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate to RDS"
  type        = list(string)
}

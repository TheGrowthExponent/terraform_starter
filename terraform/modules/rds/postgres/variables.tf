################ Variables ################
variable "db_name" {
  type        = string
  description = "Name of RDS DB instance"
}

variable "tags" {
  description = "Shared tags."
}

variable "db_admin_user" {
  type        = string
  description = "Backend database admin username. This variable should be retrieved from an [environment variable](https://www.terraform.io/cli/config/environment-variables#tf_var_name) or a secure secret store like [AWS Secrets Manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret). DO NOT HARDCODE."
  sensitive   = true
}

variable "db_subnet_group_name" {
  type        = string
  description = "Name of subnet group for RDS"
}

variable "subnet_ids" {
  description = "Subnets to allow access to RDS"
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate to RDS"
}

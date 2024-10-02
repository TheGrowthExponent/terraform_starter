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

variable "aws_availability_zones" {}
variable "ecs_target_group" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "sg" {}
variable "ecs_role" {}
variable "aws_key" {}
variable "log_group" {}
variable "aws_ami" {}
variable "aws_ecr_repository" {}
variable "aws_ecr_repository_version" {
  default = "latest"
}

variable "vcpu" {
  description = "The CPU of ECS Task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "The Memory of ECS Task"
  type        = number
  default     = 512
}

variable "sns_notifications_topic" {}

variable "region" {
  default = "ap-southeast-2"
}

variable "asg_max_size" {
  description = "max_size."
  type        = number
  default     = 1
}

variable "asg_min_size" {
  description = "min_size."
  type        = number
  default     = 1
}

variable "maximum_scaling_step_size" {
  description = "maximum_scaling_step_size."
  type        = number
  default     = 1
}

variable "minimum_scaling_step_size" {
  description = "minimum_scaling_step_size."
  type        = number
  default     = 1
}

variable "target_capacity" {
  description = "target_capacity."
  type        = number
  default     = 1
}

variable "s3_bucket" {}

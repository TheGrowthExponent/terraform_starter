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

variable "ecs_target_group" {}

variable "ecs_subnet_a" {}

variable "ecs_subnet_b" {}

variable "ecs_subnet_c" {}

variable "ecs_sg" {}

variable "ecs_role" {}

variable "aws_key" {}

variable "log_group" {}
variable "aws_ami" {}

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

variable "tags" {
  description = "Shared tags."
}
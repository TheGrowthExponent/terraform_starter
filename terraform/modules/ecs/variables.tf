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

variable "aws_kms_key_arn" {
  description = "KMS key for project."
  type        = string
}

variable "aws_cloudwatch_log_group" {
  description = "Cloudwatch log group for project logs."
  type        = string
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
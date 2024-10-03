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

variable "ecs_target_group" {
  description = "The ECS Target Group"
  type        = map(string)
}

# variable "public_subnets" {
#   description = "The Public Subnet IDs"
#   type        = list(string)
# }

variable "private_subnets" {
  description = "The Private Subnet IDs"
  type        = list(string)
}

variable "sg" {
  description = "The Security Group"
  type        = map(string)
}

variable "ecs_role" {
  description = "The ECS Role"
  type        = map(string)
}

variable "aws_key" {
  description = "The AWS Key"
  type        = map(string)
}

variable "log_group" {
  description = "The Log Group"
  type        = map(string)
}

variable "aws_ami" {
  description = "The AMI"
  type        = map(string)
}

variable "aws_ecr_repository" {
  description = "The ECR Repository"
  type        = map(string)
}

variable "aws_ecr_repository_version" {
  description = "The ECR Repository Version"
  type        = string
  default     = "latest"
}

variable "cpu" {
  description = "The CPU of ECS Task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "The Memory of ECS Task"
  type        = number
  default     = 512
}

variable "sns_notifications_topic" {
  description = "The SNS Notifications Topic"
  type        = map(string)
}

variable "region" {
  description = "The region"
  type        = string
  default     = "ap-southeast-2"
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

variable "s3_bucket" {
  description = "The S3 Bucket"
  type        = map(string)
}

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

variable "ecs_target_group_arn" {
  description = "The ECS Target Group ARN"
  type        = string
}

# variable "public_subnets" {
#   description = "The Public Subnet IDs"
#   type        = list(string)
# }

variable "private_subnets" {
  description = "The Private Subnet IDs"
  type        = list(string)
}

variable "sg_id" {
  description = "The Security Group"
  type        = string
}

variable "ecs_role_arn" {
  description = "The ECS Role ARN"
  type        = string
}

variable "aws_key" {
  description = "The AWS Key"
  type        = string
}

variable "log_group_name" {
  description = "The Log Group"
  type        = string
}

variable "aws_ami" {
  description = "The AMI"
  type        = string
}

variable "aws_ecr_repository_repository_url" {
  description = "The ECR Repository URL"
  type        = string
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

variable "sns_notifications_topic_arn" {
  description = "The SNS Notifications Topic"
  type        = string
}

variable "region" {
  description = "The region"
  type        = string
  default     = "us-east-1"
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

variable "s3_bucket_name" {
  description = "The S3 Bucket"
  type        = string
}

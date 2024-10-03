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

variable "src_path" {
  description = "Path to the lambda function code."
  type        = string
}

variable "lambda_role_arn" {
  description = "The the IAM role that the Lambda function assumes when it executes your function to access any other AWS services."
  type        = string
}

variable "subnet_ids" {
  description = "The Subnet IDs"
  type        = list(string)
}

variable "load_balancer_sg_id" {
  description = "The Security Group for the Load Balancer"
  type        = string
}

variable "lambda_log_level" {
  description = "The log level for the Lambda function"
  type        = string
  default     = "INFO"
}

variable "secret_name" {
  description = "The name of the secret in Secrets Manager"
  type        = string
}

variable "queue_arn" {
  description = "The queue ARN"
  type        = string
}

variable "queue_name" {
  description = "The queue name"
  type        = string
}

variable "bucket_name" {
  description = "The S3 bucket name"
  type        = string
}

variable "bucket_arn" {
  description = "The S3 bucket ARN"
  type        = string
}

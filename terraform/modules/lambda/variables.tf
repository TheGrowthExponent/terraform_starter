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

variable "lambda_role" {
  description = "The the IAM role that the Lambda function assumes when it executes your function to access any other AWS services."
  type        = map(string)
}

variable "subnet_ids" {
  description = "The Subnet IDs"
  type        = list(string)
}

variable "load_balancer_sg" {
  description = "The Security Group for the Load Balancer"
  type        = map(string)
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

variable "queue" {
  description = "The queue"
  type        = map(string)
}

variable "bucket" {
  description = "The S3 bucket"
  type        = map(string)
}

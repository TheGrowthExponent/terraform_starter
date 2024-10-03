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

variable "account_id" {
  description = "AWS Account ID"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.account_id) == 12 && length(regexall("[^0-9]", var.account_id)) == 0
    error_message = "The account number must be 12 characters, and only contain numbers."
  }
}

variable "load_balancer" {
  description = "ARN of the load balancer"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket"
  type        = map(string)
}

variable "log_group" {
  description = "ARN of the log group"
  type        = map(string)
}

# variable "dynamodb" {
#   description = "ARN of the dynamodb table"
#   type        = string
# }

variable "sqs_queue" {
  description = "The SQS queue"
  type        = map(string)
}

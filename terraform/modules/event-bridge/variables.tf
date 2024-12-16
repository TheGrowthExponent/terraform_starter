variable "scheduler_name" {
  description = "The name of the CloudWatch Event Rule"
  type        = string
}

variable "rate" {
  description = "The rate at which the rule should be triggered"
  type        = string
  default     = "rate(24 hours)"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  type        = string
}

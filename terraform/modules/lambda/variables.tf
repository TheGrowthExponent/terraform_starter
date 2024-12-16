################ Variables ################
variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
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

variable "queue_arn" {
  description = "The queue ARN"
  type        = string
}

variable "bucket_arn" {
  description = "The S3 bucket ARN"
  type        = string
}

variable "lambda_memory_size" {
  description = "The amount of memory that your function has access to."
  type        = string
  default     = 256
}

variable "lambda_timeout" {
  description = "The amount of seconds that Lambda allows a function to run before stopping it."
  type        = string
  default     = 30
}

variable "env_vars" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

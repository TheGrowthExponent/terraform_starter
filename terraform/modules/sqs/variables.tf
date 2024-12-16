################ Variables ################
variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue"
  type        = string
  default     = "30"
}

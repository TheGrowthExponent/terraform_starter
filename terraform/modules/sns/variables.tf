################ Variables ################
variable "account_id" {
  description = "AWS Account ID"
  type        = string
  default     = ""
}

variable "topic_name" {
  description = "The name of the SNS topic."
  type        = string
  default     = ""
}

variable "notification_recipients" {
  description = "Email address list of notification recipients."
  type        = list(string)
}

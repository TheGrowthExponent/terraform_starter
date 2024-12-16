################ Variables ################
variable "account_id" {
  description = "AWS Account ID"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.account_id) == 12 && length(regexall("[^0-9]", var.account_id)) == 0
    error_message = "The account number must be 12 characters, and only contain numbers."
  }
}

variable "topic_name" {
  description = "The name of the SNS topic."
  type        = string
}

variable "notification_recipients" {
  description = "Email address list of notification recipients."
  type        = list(string)
}

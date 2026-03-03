################ Variables ################
variable "bucket_name" {
  description = "S3 bucket to create."
  type        = string
}

variable "tags" {
  description = "S3 bucket tags."
  type        = map(string)
}

variable "public" {
  description = "Enable public access for S3 bucket (for web hosting)"
  type        = bool
  default     = false
}

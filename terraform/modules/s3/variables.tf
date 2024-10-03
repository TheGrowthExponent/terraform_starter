################ Variables ################
variable "bucket_name" {
  description = "S3 bucket to create."
  type        = string
}

variable "tags" {
  description = "S3 bucket tags."
  type        = map(string)
}

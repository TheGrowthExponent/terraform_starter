################ Variables ################
variable "hosted_zone_id" {
  description = "The Route53 Hosted Zone ID"
  type        = string
}

variable "host_name" {
  description = "The Route53 Host Name"
  type        = string
}

################ Variables ################
variable "secret_name" {
  description = "Name of the secret to be created."
  type        = string
  default     = "example"
}

variable "secret_description" {
  description = "Description of the secret to be created."
  type        = string
  default     = "My secret"
}

################ Variables ################
variable "table_name" {
  description = "DDB table name."
  type        = string
}

variable "tags" {
  description = "DDB tags."
  type        = map(string)
}

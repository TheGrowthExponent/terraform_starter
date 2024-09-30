################ Variables ################
variable "application_name" {
  description = "Name of the application."
  type        = string
  default     = "example"
}

variable "environment" {
  description = "Name of the environment."
  type        = string
  default     = "dev"

  validation {
    condition     = length(var.environment) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.environment)) == 0
    error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
  }
}

variable "instance_name" {
  description = "Name of the instance."
  default     = "example instance"
}

variable "ami" {
  description = "The AMI to use for the instance."
  type        = string
}

variable "public_key" {
  description = "The public key to use for the instance."
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDc9vCDIU2sxtYwkhIm+UdAHrYNCpI9spHLcSoCEoNKDaSLDxs7Uxefk2bxZBxJD205Zg5opAXT23gJKkvyK5E+KJG9la34WWQlb6BpWrjomiON9zDn3epthE4J/IpaR4b2yphqd6ucb9QbBrT7fatLf/oNg1MXZsenG0Vizc/6eCprMm2RYa5g72HvrMMFZT0jTE7QoIK/3RFkIWS9sTDbKpFt4jjql2Leu3iaXyALVUF6U5DPFciHGhJy9zsE0tuqj5YqtFKnU12e6rjJihXjEvGeztJvRv8DfVIxrqaFPgG/XicW5qg5nm/pAF820pUX8XG1RK03JCMtL3f5wGKczJXTrFkePA1dkirkY2kdIEsLEVigbIXB0vvkU7QIS+i6ji+B8RxvpXm9qC+GxDoWew9EefMXvSdG/dKw1XD6IdlXgswxSOM0hMhrcSYaae8ukVkwmeTxsSTvdKXvdgdvhsSnGpl78PM0TqRFWeY1APnI1n4LNcI/pq5Gg0OF4vEo admin@server.local"
}

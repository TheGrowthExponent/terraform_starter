############### Variables ################
variable "efs_name" {
  description = "Name of the efs file system."
  type        = string
}

variable "transition_to_ia" {
    description = "The lifecycle policy for the EFS file system."
    type        = string
  default = "AFTER_7_DAYS"
}

variable "private_subnets" {
    description = "The private subnets to use for the EFS mount targets."
    type        = list(string)
}

variable "shared_efs_sg_id" {
    description = "The security group id for the EFS file system."
    type        = string
}

variable "ec2_role_arn" {
    description = "The ARN of the IAM role to attach the policy to."
    type        = string
}

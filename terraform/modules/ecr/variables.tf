################ Variables ################
variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "ecs_role_arn" {
  description = "The ECS role ARN"
  type        = string
}

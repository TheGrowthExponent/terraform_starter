variable "subnet_ids" {
  description = "The Private Subnet IDs"
  type        = list(string)
}

variable "environment" {
  description = "Environment to be used e.g dev/prod/uat"
  type        = string
}

variable "aws_ecr_repository" {}
variable "aws_ecr_repository_version" {
  default = "latest"
}

variable "ecs_instance_role" {
  description = "ECS Instance Role"
}

variable "batch_service_role" {
  description = "Batch Service Role"
}

variable "ecs_task_execution_role" {
  description = "ECS Task Execution Role"
}

variable "vcpu" {
  description = "The CPU of ECS Task"
  type        = number
  default     = 512
}

variable "memory" {
  description = "The Memory of ECS Task"
  type        = number
  default     = 1024
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

variable "batch_name" {
  description = "The name of the batch job definition"
  type        = string
  # "${var.project_name}-${var.environment}-${var.software_product_name}"
}

variable "platform_capabilities" {
  description = "The platform capabilities of the batch job definition"
  type        = list(string)
  default     = ["EC2", "FARGATE"]
}

variable "compute_environment" {
  description = "The compute environment type"
  type        = string
  default     = "FARGATE"
}

variable "security_group_ids" {
  description = "The security group ids of the batch job definition"
  type        = list(string)
}

variable "tags" {
  description = "Batch tags."
}

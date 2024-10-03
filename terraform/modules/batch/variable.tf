variable "subnet_ids" {
  description = "The Private Subnet IDs"
  type        = list(string)
}

variable "aws_ecr_repository" {
  description = "The name of the ECR repository"
  type        = map(string)
}

variable "aws_ecr_repository_version" {
  description = "The version of the ECR repository"
  type        = string
  default     = "latest"
}

variable "ecs_instance_role" {
  description = "ECS Instance Role"
  type        = map(string)
}

variable "batch_service_role" {
  description = "Batch Service Role"
  type        = map(string)
}

variable "ecs_task_execution_role" {
  description = "ECS Task Execution Role"
  type        = map(string)
}

variable "vcpu" {
  description = "The vCPU of ECS Task"
  type        = number
  default     = 0.25
}

variable "memory" {
  description = "The Memory of ECS Task"
  type        = number
  default     = 512
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

variable "batch_name" {
  description = "The name of the batch job definition"
  type        = string
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
  type        = map(string)
}

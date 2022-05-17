################ Root ################
output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

output "tags" {
  value = local.tags
}

################ VPC ################
output "load_balancer_security_group_arn" {
  description = "load_balancer_security_group_arn"
  value       = module.vpc.load_balancer_security_group_arn
}

output "ecs_task_security_group_arn" {
  description = "ecs_task_security_group_arn"
  value       = module.vpc.ecs_task_security_group_arn
}

################ IAM Roles ################

################ EC2 ################
output "aws_key" {
  description = "aws_key"
  value       = module.ec2.aws_key
}

output "aws_ecr_repository_arn" {
  description = "aws_ecr_repository_arn"
  value       = module.ecr.aws_ecr_repository_arn
}

output "aws_ecr_repository_url" {
  description = "aws_ecr_repository_url"
  value       = module.ecr.aws_ecr_repository_url
}

output "aws_ecr_authorization_token" {
  description = "aws_ecr_authorization_token"
  value       = data.aws_ecr_authorization_token.token
  sensitive   = true
}

output "aws_ecs_cluster_name" {
  description = "aws_ecs_cluster_name"
  value       = module.ecs.aws_ecs_cluster
  sensitive   = true
}

output "aws_ecs_cluster_arn" {
  description = "aws_ecs_cluster_arn"
  value       = module.ecs.aws_ecs_cluster_arn
  sensitive   = true
}

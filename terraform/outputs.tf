# ################ Root ################
# output "aws_region" {
#   description = "AWS region"
#   value       = var.region
# }
#
# output "tags" {
#   value = local.tags
# }
#
# ################ VPC ################
# output "lb_security_group_arn" {
#   description = "security_group_arn"
#   value       = module.vpc.sg_lb.arn
# }
#
# output "ecs_security_group_arn" {
#   description = "security_group_arn"
#   value       = module.vpc.sg_ecs.arn
# }
#
# ################ S3 ################
# output "aws_s3_bucket" {
#   description = "aws_s3_bucket"
#   value       = module.s3.aws_s3_bucket.id
# }
#
# ################ IAM Roles ################
# output "ecs_role" {
#   value = module.iam.ecs_role
# }
#
# output "lambda_role" {
#   value = module.iam.lambda_role.id
# }
#
# ################ EC2 ################
# output "aws_key" {
#   description = "aws_key"
#   value       = module.ec2.aws_key
#   sensitive   = true
# }
#
# ################ ECR ################
# output "aws_ecr_repository_arn" {
#   description = "aws_ecr_repository_arn"
#   value       = module.ecr.aws_ecr_repository.arn
# }
#
# output "aws_ecr_repository_url" {
#   description = "aws_ecr_repository_url"
#   value       = module.ecr.aws_ecr_repository.repository_url
# }
#
# # ################ ECS ################
# # output "aws_ecs_cluster_name" {
# #   description = "aws_ecs_cluster_name"
# #   value       = module.ecs[0].ecs_cluster.id
# # }
# #
# # output "aws_ecs_cluster_arn" {
# #   description = "aws_ecs_cluster_arn"
# #   value       = module.ecs[0].ecs_cluster.arn
# # }
#
# ################ ACM ################
# output "aws_acm_certificate_arn" {
#   description = "aws_acm_certificate_arn"
#   value       = module.acm.aws_acm_certificate.arn
# }
#
# ################ SNS ################
# output "sns_notifications_topic" {
#   description = "sns_notifications_topic"
#   value       = module.sns.sns_notifications_topic.arn
# }
#
# ################ SQS ################
# output "aws_sqs_queue" {
#   description = "aws_sqs_queue"
#   value       = module.sqs.aws_sqs_queue.arn
# }

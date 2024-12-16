# ################ Providers ################


module "acm" {
  source           = "TheGrowthExponent/acm/aws"
  version          = "1.0.0"
  environment      = var.environment
  application_name = var.application_name
  hosted_zone_id   = var.hosted_zone_id
  host_name        = var.host_name
}

module "apigw" {
  count  = var.create_api-gateway_module ? 1 : 0
  source = "./modules/api-gateway"
  # api_gw_disable_resource_creation   = var.api_gw_disable_resource_creation
  api_gw_endpoint_configuration_type = var.api_gw_endpoint_configuration_type
  # stage_name                         = var.environment
  # method                             = var.api_gw_method
  #  lambda_arn                            = module.lambda.lambda_arn
  #  lambda_name                           = module.lambda.lambda_name
  # dependency_list = var.api_gw_dependency_list
  account_id = local.account_id
  # apigw_role     = module.iam.apigw_role
  certificate_arn = module.acm.aws_acm_certificate.arn
  host_name       = var.host_name
  hosted_zone_id  = var.hosted_zone_id
}

module "auto_scaling" {
  count            = var.create_auto_scaling_module ? 1 : 0
  source           = "./modules/auto-scaling"
  environment      = var.environment
  application_name = var.application_name
  ecs_cluster_name = module.ecs[0].ecs_cluster.name
  ecs_service_name = module.ecs[0].ecs_service.name
}

module "batch_fargate" {
  count                       = var.create_batch_module ? 1 : 0
  source                      = "./modules/batch"
  batch_name                  = "app-${var.application_name}-${var.environment}-ExampleBatch-fargate"
  compute_environment         = "FARGATE"
  batch_service_role_arn      = module.iam.batch_role.arn
  aws_ecr_repository_url      = module.ecr.aws_ecr_repository.repository_url
  aws_ecr_repository_version  = "v0.0.1"
  ecs_instance_role_arn       = module.iam.ec2_instance_profile.arn
  ecs_task_execution_role_arn = module.iam.ecs_role.arn
  memory                      = var.batch_memory
  s3_bucket_name              = module.s3.aws_s3_bucket.bucket
  security_group_ids          = [module.vpc.sg_batch.id]
  subnet_ids                  = [module.vpc.private_subnet_a.id, module.vpc.private_subnet_b.id]
  vcpu                        = var.batch_fargate_vcpu
}

module "batch_ec2" {
  count                       = var.create_batch_module ? 1 : 0
  source                      = "./modules/batch"
  batch_name                  = "app-${var.application_name}-${var.environment}-ExampleBatch-ec2"
  compute_environment         = "EC2"
  batch_service_role_arn      = module.iam.batch_role.arn
  aws_ecr_repository_url      = module.ecr.aws_ecr_repository.repository_url
  aws_ecr_repository_version  = "v0.0.1"
  ecs_instance_role_arn       = module.iam.ec2_instance_profile.arn
  ecs_task_execution_role_arn = module.iam.ecs_role.arn
  memory                      = var.batch_memory
  s3_bucket_name              = module.s3.aws_s3_bucket.bucket
  security_group_ids          = [module.vpc.sg_batch.id]
  subnet_ids                  = [module.vpc.private_subnet_a.id, module.vpc.private_subnet_b.id]
  vcpu                        = var.batch_ec2_vcpu
}

module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = "app-${var.application_name}-${var.environment}-ExampleTable"
  tags       = { purpose = "Application storage" }
}

module "ec2" {
  source               = "./modules/ec2"
  environment          = var.environment
  application_name     = var.application_name
  instance_name        = "app-${var.application_name}-${var.environment}"
  ami                  = data.aws_ami.ubuntu.id
  private_subnet_id    = module.vpc.private_subnet_a.id
  ec2_instance_profile = module.iam.ec2_instance_profile.id
  sg_id                = module.vpc.sg_ec2.id
  user_data            = local.user_data
  create_ec2_instance  = var.create_ec2_instance
}

module "ecr" {
  source          = "./modules/ecr"
  ecs_role_arn    = module.iam.ecs_role.arn
  repository_name = "app-${var.application_name}-${var.environment}"
}

module "ecs" {
  count                     = var.create_ecs_module ? 1 : 0
  source                    = "./modules/ecs"
  environment               = var.environment
  application_name          = var.application_name
  region                    = local.region
  aws_key                   = module.ec2.aws_key.key_name
  log_group_name            = module.logs.log_group.id
  asg_max_size              = 2
  asg_min_size              = 1
  maximum_scaling_step_size = 1
  minimum_scaling_step_size = 1
  target_capacity           = 1
  ecs_role_arn              = module.iam.ecs_role.arn
  sg_id                     = module.vpc.sg_ecs.id
  aws_ami                   = data.aws_ami.ubuntu.id
  private_subnets           = [module.vpc.private_subnet_a.id]
  # public_subnets             = [module.vpc.public_subnet_a.id]
  ecs_target_group_arn              = module.load-balancer.ecs_target_group_arn
  aws_ecr_repository_repository_url = module.ecr.aws_ecr_repository.repository_url
  aws_ecr_repository_version        = "v0.0.1"
  s3_bucket_name                    = module.s3.aws_s3_bucket.id
  sns_notifications_topic_arn       = module.sns.sns_notifications_topic.arn
}

module "load-balancer" {
  source                 = "./modules/load-balancer"
  environment            = var.environment
  application_name       = var.application_name
  certificate_arn        = module.acm.aws_acm_certificate.arn
  load_balancer_sg_id    = module.vpc.sg_lb.id
  private_subnets        = [module.vpc.private_subnet_a.id, module.vpc.private_subnet_b.id]
  vpc_id                 = module.vpc.vpc.id
  authorization_endpoint = var.authorization_endpoint
  client_id              = var.client_id
  client_secret          = var.client_secret
  issuer                 = var.issuer
  token_endpoint         = var.token_endpoint
  user_info_endpoint     = var.user_info_endpoint
  internal               = false
}

module "iam" {
  source            = "./modules/iam"
  environment       = var.environment
  application_name  = var.application_name
  load_balancer_arn = module.load-balancer.alb.arn
  log_group_arn     = module.logs.log_group.arn
  s3_bucket_arn     = module.s3.aws_s3_bucket.arn
  account_id        = local.account_id
  sqs_queue_arn     = module.sqs.aws_sqs_queue.arn
  #  notifications_topic       = module.sns.sns_notifications_topic
}

module "grafana" {
  source           = "./modules/grafana"
  environment      = var.environment
  application_name = var.application_name
  grafana_role_arn = module.iam.grafana_service.arn
  # sg_ids           = module.vpc.sg_grafana.id
  # subnet_ids       = var.private_subnets
}

module "prometheus" {
  source                     = "./modules/prometheus"
  environment                = var.environment
  application_name           = var.application_name
  obs_platform_log_group_arn = module.logs.log_group.arn
}

module "lambda1-lambda" {
  count               = var.create_lambda_module ? 1 : 0
  source              = "./modules/lambda"
  function_name       = "${var.application_name}-lambda1"
  src_path            = "${path.root}/lambda1"
  lambda_role_arn     = module.iam.lambda_role.arn
  lambda_memory_size  = 128
  lambda_timeout      = 300
  load_balancer_sg_id = module.vpc.sg_lb.id
  bucket_arn          = module.s3.aws_s3_bucket.arn
  queue_arn           = module.sqs.aws_sqs_queue.arn
  subnet_ids          = [module.vpc.private_subnet_a.id, module.vpc.private_subnet_b.id]
  env_vars = {
    ENV         = var.environment
    LOG_LEVEL   = "DEBUG"
    SECRET_NAME = "xxx"
    QUEUE_NAME  = module.sqs.aws_sqs_queue.id
    BUCKET_NAME = module.s3.aws_s3_bucket.id
  }
}

# module "lambda1-schedule" {
#   source               = "./modules/event-bridge"
#   scheduler_name       = module.lambda1-lambda.lambda.function_name
#   rate                 = "cron(0 12 * * ? *)"
#   lambda_function_arn  = module.lambda1-lambda.lambda.arn
#   lambda_function_name = module.lambda1-lambda.lambda.function_name
# }

module "logs" {
  source                          = "./modules/logs"
  environment                     = var.environment
  application_name                = var.application_name
  create_aws_cloudwatch_dashboard = false
}

module "postgres" {
  count                  = var.create_postgres_module ? 1 : 0
  source                 = "./modules/rds"
  db_admin_user          = "dbadmin"
  db_name                = "${var.application_name}${var.environment}" # DBName must begin with a letter and contain only alphanumeric characters.
  db_subnet_group_name   = "${var.application_name}-${var.environment}"
  subnet_ids             = [module.vpc.private_subnet_a.id, module.vpc.private_subnet_b.id]
  vpc_security_group_ids = [module.vpc.sg_rds.id]
  instance_class         = "db.serverless"
}

module "route53" {
  source                 = "./modules/route53"
  load_balancer_dns_name = module.load-balancer.alb.dns_name
  load_balancer_zone_id  = module.load-balancer.alb.zone_id
  hosted_zone_id         = var.hosted_zone_id
  host_name              = var.host_name
}

module "s3" {
  source      = "./modules/s3"
  tags        = { purpose = "Application storage" }
  bucket_name = "${var.application_name}-${local.account_id}-${local.region}-${var.environment}"
}

module "sns" {
  source                  = "./modules/sns"
  topic_name              = "app-notification-topic-${var.application_name}-${var.environment}"
  notification_recipients = var.notification_recipients
  account_id              = local.account_id
}

module "sns-error" {
  source                  = "./modules/sns"
  topic_name              = "app-error-notification-topic-${var.application_name}-${var.environment}"
  notification_recipients = var.notification_recipients
  account_id              = local.account_id
}

module "sqs" {
  source     = "./modules/sqs"
  queue_name = "app-${var.application_name}-${var.environment}-ExampleQueue"
}

module "vpc" {
  source           = "./modules/vpc"
  environment      = var.environment
  application_name = var.application_name
  #  private_subnets  = ""
  #  public_subnets   = ""
  #  vpc_id           = ""
}

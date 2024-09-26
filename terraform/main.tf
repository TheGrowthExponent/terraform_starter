################ Providers ################
provider "aws" {
  profile = var.profile
  region  = local.region

  #  assume_role {
  #    role_arn     = "arn:aws:iam::${var.account_id}:role/cicd-role"
  #    session_name = "ci-cd"
  #    external_id  = "asdf-asdf-asdf"
  #  }
  default_tags {
    tags = local.tags
  }
}

module "acm" {
  source           = "TheGrowthExponent/acm/aws"
  version          = "1.0.0"
  environment      = var.environment
  application_name = var.application_name
  hosted_zone_id   = var.hosted_zone_id
  host_name        = var.host_name
}

module "apigw" {
  source                             = "./modules/api-gateway"
  api_gw_disable_resource_creation   = var.api_gw_disable_resource_creation
  api_gw_endpoint_configuration_type = var.api_gw_endpoint_configuration_type
  stage_name                         = var.environment
  method                             = var.api_gw_method
  #  lambda_arn                            = module.lambda.lambda_arn
  region = var.region
  #  lambda_name                           = module.lambda.lambda_name
  dependency_list = var.api_gw_dependency_list
  account_id                         = var.account_id
  apigw_role                         = module.iam.apigw_role
  certificate                        = module.acm.aws_acm_certificate
  host_name                          = var.host_name
  hosted_zone_id                     = var.hosted_zone_id
}

module "auto_scaling" {
  source           = "./modules/auto-scaling"
  environment      = var.environment
  application_name = var.application_name
  ecs_cluster      = module.ecs.ecs_cluster
  ecs_service      = module.ecs.ecs_service
}

module "dynamodb" {
  source           = "./modules/dynamodb"
  environment      = var.environment
  application_name = var.application_name
  account_id       = var.account_id
  region           = var.region
}

module "ec2" {
  source           = "./modules/ec2"
  environment      = var.environment
  application_name = var.application_name
}

module "ecr" {
  source           = "./modules/ecr"
  environment      = var.environment
  application_name = var.application_name
  ecs_role         = module.iam.ecs_role
}

module "ecs" {
  source                     = "./modules/ecs"
  environment                = var.environment
  application_name           = var.application_name
  region                     = var.region
  aws_key                    = module.ec2.aws_key
  log_group                  = module.logs.log_group
  asg_max_size               = 2
  asg_min_size               = 1
  maximum_scaling_step_size  = 1
  minimum_scaling_step_size  = 1
  target_capacity            = 1
  ecs_role                   = module.iam.ecs_role
  sg                         = module.vpc.sg_ecs
  aws_availability_zones     = module.vpc.aws_availability_zones
  aws_ami                    = data.aws_ami.ubuntu
  private_subnets            = [module.vpc.private_subnet_a.id]
  public_subnets             = [module.vpc.public_subnet_a.id]
  ecs_target_group           = module.elb.ecs_target_group
  aws_ecr_repository         = module.ecr.aws_ecr_repository
  aws_ecr_repository_version = "v0.0.1"
  s3_bucket                  = module.s3.aws_s3_bucket
  sns_notifications_topic    = module.sns.sns_notifications_topic
}

module "elb" {
  source                 = "./modules/elb"
  environment            = var.environment
  application_name       = var.application_name
  certificate            = module.acm.aws_acm_certificate
  load_balancer_sg       = module.vpc.sg_lb
  private_subnets        = [module.vpc.private_subnet_a.id]
  public_subnets         = [module.vpc.public_subnet_a.id]
  vpc_id                 = module.vpc.vpc.id
  authorization_endpoint = var.authorization_endpoint
  client_id              = var.client_id
  client_secret          = var.client_secret
  issuer                 = var.issuer
  token_endpoint         = var.token_endpoint
  user_info_endpoint     = var.user_info_endpoint
}

module "iam" {
  source           = "./modules/iam"
  environment      = var.environment
  application_name = var.application_name
  elb              = module.elb.elb
  log_group        = module.logs.log_group
  s3_bucket        = module.s3.aws_s3_bucket
  account_id       = var.account_id
  sqs_queue        = module.sqs.aws_sqs_queue
  #  notifications_topic       = module.sns.sns_notifications_topic
  #  error_notifications_topic = module.sns.sns_error_notifications_topic
}

#module "lambda" {
#  source           = "./modules/lambda"
#  environment      = var.environment
#  application_name = var.application_name
#  #  region           = var.region
#  #  aws_key          = module.ec2.aws_key
#  #  log_group        = module.logs.log_group
#  lambda_role      = module.iam.lambda_role
#  load_balancer_sg = module.vpc.sg_lb
#  bucket           = module.s3.aws_s3_bucket
#  lambda_log_level = "DEBUG"
#  queue            = module.sqs.aws_sqs_queue
#  secret_name      = "xxx"
#  subnet_ids       = [module.vpc.private_subnet_a.id, module.vpc.private_subnet_b.id]
#}

module "logs" {
  source           = "./modules/logs"
  environment      = var.environment
  application_name = var.application_name
}

module "route53" {
  source           = "./modules/route53"
  environment      = var.environment
  application_name = var.application_name
  elb              = module.elb.elb
  hosted_zone_id   = var.hosted_zone_id
  host_name        = var.host_name
}

module "s3" {
  source = "./modules/s3"
  tags   = { purpose = "Application storage" }
  bucket = "${var.application_name}-${var.account_id}-${var.region}-${var.environment}"
}

module "sns" {
  source                  = "./modules/sns"
  environment             = var.environment
  application_name        = var.application_name
  account_id              = var.account_id
  notification_recipients = var.notification_recipients
}

module "sqs" {
  source           = "./modules/sqs"
  environment      = var.environment
  application_name = var.application_name
}

module "vpc" {
  source           = "./modules/vpc"
  environment      = var.environment
  application_name = var.application_name
  #  private_subnets  = ""
  #  public_subnets   = ""
  #  vpc_id           = ""
}

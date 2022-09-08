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
  source             = "./modules/acm"
  environment        = var.environment
  application_name   = var.application_name
  hosted_zone_id     = var.hosted_zone_id
  host_name          = var.host_name
  aws_route53_record = module.route53.aws_route53_record
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
}

module "ecs" {
  source                    = "./modules/ecs"
  environment               = var.environment
  application_name          = var.application_name
  region                    = var.region
  aws_key                   = module.ec2.aws_key
  log_group                 = module.logs.log_group
  asg_max_size              = 1
  asg_min_size              = 1
  maximum_scaling_step_size = 1
  minimum_scaling_step_size = 1
  target_capacity           = 1
  tags                      = local.tags
  ecs_role                  = module.iam.ecs_service_role
  ecs_sg                    = module.vpc.ecs_sg
  load_balancer_sg          = module.vpc.load_balancer_sg
  ecs_subnet_a              = module.vpc.ecs_subnet_a
  ecs_subnet_b              = module.vpc.ecs_subnet_b
  ecs_subnet_c              = module.vpc.ecs_subnet_c
  ecs_target_group          = module.elb.ecs_target_group
  aws_availability_zones    = module.vpc.aws_availability_zones
  aws_ami                   = data.aws_ami.ubuntu
}

module "elb" {
  source                 = "./modules/elb"
  environment            = var.environment
  application_name       = var.application_name
  hosted_zone_id         = var.hosted_zone_id
  load_balancer_sg       = module.vpc.load_balancer_sg
  load_balancer_subnet_a = module.vpc.load_balancer_subnet_a
  load_balancer_subnet_b = module.vpc.load_balancer_subnet_b
  load_balancer_subnet_c = module.vpc.load_balancer_subnet_c
  vpc                    = module.vpc.vpc
  tags                   = local.tags
}
module "iam" {
  source                    = "./modules/iam"
  environment               = var.environment
  application_name          = var.application_name
  elb                       = module.elb.elb
  bucket                    = module.s3.aws_s3_bucket
  queue                     = module.sqs.aws_sqs_queue
  notifications_topic       = module.sns.sns_notifications_topic
  error_notifications_topic = module.sns.sns_error_notifications_topic
  tags                      = local.tags
}

module "lambda" {
  source           = "./modules/lambda"
  environment      = var.environment
  application_name = var.application_name
  region           = var.region
  aws_key          = module.ec2.aws_key
  log_group        = module.logs.log_group
  lambda_role      = module.iam.lambda_role
  load_balancer_sg = module.vpc.load_balancer_sg
  ecs_subnet_a     = module.vpc.ecs_subnet_a
  ecs_subnet_b     = module.vpc.ecs_subnet_b
  ecs_subnet_c     = module.vpc.ecs_subnet_c
  tags             = local.tags
}

module "logs" {
  source           = "./modules/logs"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "route53" {
  source           = "./modules/route53"
  environment      = var.environment
  application_name = var.application_name
  elb              = module.elb.elb
  hosted_zone_id   = var.hosted_zone_id
  host_name        = var.host_name
  tags             = local.tags
}

module "s3" {
  source           = "./modules/s3"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
  account_id       = var.account_id
  region           = var.region
}

module "sns" {
  source                  = "./modules/sns"
  environment             = var.environment
  application_name        = var.application_name
  account_id              = var.account_id
  notification_recipients = var.notification_recipients
  tags                    = local.tags
}

module "sqs" {
  source           = "./modules/sqs"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "vpc" {
  source           = "./modules/vpc"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

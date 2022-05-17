################ Providers ################
provider "aws" {
  profile = var.profile
  region  = local.region

  #  assume_role {
  #    role_arn     = "arn:aws:iam::${var.account_id}:role/cicd-role"
  #    session_name = "ci-cd"
  #    external_id  = "asdf-asdf-asdf"
  #  }
}

module "ec2" {
  source           = "./modules/ec2"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "ecr" {
  source           = "./modules/ecr"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "ecs" {
  source                    = "./modules/ecs"
  environment               = var.environment
  application_name          = var.application_name
  aws_kms_key_arn           = module.ec2.aws_key
  aws_cloudwatch_log_group  = module.logs.aws_cloudwatch_log_group
  asg_max_size              = 1
  asg_min_size              = 1
  maximum_scaling_step_size = 1
  minimum_scaling_step_size = 1
  target_capacity           = 1
  tags                      = local.tags
}

module "elb" {
  source           = "./modules/elb"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "logs" {
  source           = "./modules/logs"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "s3" {
  source           = "./modules/s3"
  environment      = var.environment
  application_name = var.application_name
  tags             = local.tags
}

module "vpc" {
  source           = "./modules/vpc"
  environment      = var.environment
  application_name = var.application_name
  vpc_id           = var.vpc_id
  subnets_private  = var.subnets_private
  subnets_public   = var.subnets_public
  tags             = local.tags
}

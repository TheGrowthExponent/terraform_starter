# data "aws_region" "current" {}

data "aws_ssm_parameter" "jwt_secret" {
  name            = "/my/jwt_secret"
  with_decryption = true
}

data "aws_ssm_parameter" "github_api_key" {
  name            = "/my/github_api_key"
  with_decryption = true
}

data "aws_ssm_parameter" "mailerlite_api_key" {
  name            = "/my/mailerlite_api_key"
  with_decryption = true
}

data "aws_ssm_parameter" "hubspot_app_token" {
  name            = "/my/hubspot_app_token"
  with_decryption = true
}

data "aws_ssm_parameter" "deepseek_api_key" {
  name            = "/my/deepseek_api_key"
  with_decryption = true
}

data "aws_s3_bucket" "source" {
  bucket = "source.${var.host_name}"
}

data "aws_caller_identity" "this" {}


# data "aws_ecr_repository" "service" {
#   name = module.ecr.aws_ecr_repository.id
# }

#data "aws_ecr_image" "service_image" {
#  repository_name = module.ecr.aws_ecr_repository
#  image_tag       = "latest"
#}

# data "aws_ecr_authorization_token" "token" {
# }

# data "aws_ami" "amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"]
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }
# }

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

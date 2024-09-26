terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.68.0"
    }
  }
  cloud {
    organization = "TGE"

    workspaces {
      # This tag would be present on multiple workspaces
      # The workspace would be selected at runtime by specifying env variable TF_WORKSPACE
      tags = ["solution:terraform-starter"]
    }
  }
}

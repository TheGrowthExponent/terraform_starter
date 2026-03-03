terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }

  backend "s3" {}
  // Backend config is loaded from backend-dev.hcl or backend-prod.hcl via -backend-config flag.
  // See backend-dev.hcl and backend-prod.hcl for environment-specific settings.
  // https://www.terraform.io/docs/language/settings/backends/s3.html
}

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.68.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = ">= 1.28.2"
    }
  }
}

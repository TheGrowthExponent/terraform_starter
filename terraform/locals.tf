locals {
  region = var.aws_region
  required_tags = {
    Application-id   = "Terraform Starter",
    Business-Service = "ToDo"
    Environment      = var.environment,
    Owner            = "ToDo"
    Terraform        = "true"
  }
  tags = merge(var.resource_tags, local.required_tags)
}
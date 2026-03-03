// variables.tf for shared module
variable "ses_to_address" {
  description = "SES recipient address (where contact form emails are sent)."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "application_name" {
  description = "Name of the application for resource naming"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "host_name" {
  description = "The domain name to use for the ACM certificate"
  type        = string
}

variable "hubspot_app_token" {
  description = "HubSpot APP token"
  type        = string
  sensitive   = true
}

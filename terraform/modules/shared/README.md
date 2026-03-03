# Shared Terraform Module

This module provisions resources that should be created once and shared between environments (e.g., dev/prod). It enables a clear separation of shared infrastructure, such as S3 buckets, Cloudflare DNS records, logging, secrets, and email configuration.

## Usage

```hcl
module "shared" {
  source               = "../shared"
  ses_to_address       = "contact@example.com"
  environment          = "dev"
  application_name     = "my-app"
  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_zone_id   = var.cloudflare_zone_id
  host_name            = "example.com"
  hubspot_app_token    = var.hubspot_app_token
}
```

## Inputs

| Name                 | Description                                                        | Type         | Required | Default   |
|----------------------|--------------------------------------------------------------------|--------------|----------|-----------|
| ses_to_address       | SES recipient address (where contact form emails are sent)         | string       | yes      | n/a       |
| environment          | Deployment environment (e.g., dev, prod)                           | string       | yes      | n/a       |
| application_name     | Name of the application for resource naming                        | string       | yes      | n/a       |
| cloudflare_api_token | Cloudflare API token                                               | string       | yes      | n/a       |
| cloudflare_zone_id   | Cloudflare Zone ID                                                 | string       | yes      | n/a       |
| host_name            | The domain name to use for DNS and S3 buckets                      | string       | yes      | n/a       |
| hubspot_app_token    | HubSpot APP token for CRM management                               | string       | yes      | n/a       |

## Outputs

This module does not currently export outputs directly. Refer to submodules for resource outputs.

## Resources Created

- S3 buckets for root, www, wwwdev, uploads, and source
- Cloudflare DNS records for root, www, wwwdev, files, Stripe/email verification
- Logging resources (CloudWatch)
- SES email configuration
- SSM secrets for JWT, GitHub, Mailerlite, HubSpot, DeepSeek

## Example

```hcl
module "shared" {
  source               = "../shared"
  ses_to_address       = "contact@example.com"
  environment          = "dev"
  application_name     = "my-app"
  cloudflare_api_token = "your-cloudflare-token"
  cloudflare_zone_id   = "your-zone-id"
  host_name            = "example.com"
  hubspot_app_token    = "your-hubspot-token"
}
```

## Notes

- This module is intended for use in a template repository. Customize variable values for your environment.
- No organization-specific references are present except in the license.
- Ensure you review and update DNS verification records for your own domain and services.

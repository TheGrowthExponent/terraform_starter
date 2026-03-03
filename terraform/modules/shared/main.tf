// Module: shared
// Purpose: Contains all resources that should be created once and shared between environments (dev/prod),
// instead of using conditional count logic in root. This enables a clear separation of shared infra.

module "s3_root" {
  source      = "../s3"
  tags        = { purpose = "Application storage" }
  bucket_name = var.host_name
  public      = true
}

module "s3_www" {
  source      = "../s3"
  tags        = { purpose = "Application storage" }
  bucket_name = "www.${var.host_name}"
  public      = true
}

module "s3_wwwdev" {
  source      = "../s3"
  tags        = { purpose = "Application storage" }
  bucket_name = "wwwdev.${var.host_name}"
  public      = true
}

module "s3_uploads" {
  source      = "../s3"
  tags        = { purpose = "Application storage" }
  bucket_name = "files.${var.host_name}"
  public      = true
}

module "s3_source" {
  source      = "../s3"
  tags        = { purpose = "Application storage" }
  bucket_name = "source.${var.host_name}"
  public      = false
}

module "cloudflare_security" {
  source             = "../cloudflare"
  cloudflare_zone_id = var.cloudflare_zone_id
}

module "cloudflare_root" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "@"
  record_content     = "${var.host_name}.s3-website-ap-southeast-2.amazonaws.com"
  proxied            = true
  ttl                = 1
}

module "cloudflare_www" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "www"
  record_content     = "www.${var.host_name}.s3-website-ap-southeast-2.amazonaws.com"
  proxied            = true
  ttl                = 1
}

module "cloudflare_wwwdev" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "wwwdev"
  record_content     = "wwwdev.${var.host_name}.s3-website-ap-southeast-2.amazonaws.com"
  proxied            = true
  ttl                = 1
}

module "cloudflare_files" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "files"
  record_content     = "files.${var.host_name}.s3-website-ap-southeast-2.amazonaws.com"
  proxied            = true
  ttl                = 1
}

# Stripe and Email DNS Verification Records

module "cloudflare_txt_stripe_verification" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "TXT"
  record_name        = "@"
  record_content     = "stripe-verification=xxx"
  proxied            = false
  ttl                = 3600
}

module "cloudflare_txt_dmarc" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "TXT"
  record_name        = "_dmarc"
  record_content     = "\"v=DMARC1; p=quarantine; rua=mailto:xxx@dmarc-reports.cloudflare.net,mailto:support@xxx.com,mailto:rua@mailertest.com; pct=50;\""
  proxied            = false
  ttl                = 3600
}

module "cloudflare_cname_domainkey_1" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "xxx._domainkey"
  record_content     = "xxx.dkim.custom-email-domain.stripe.com."
  proxied            = false
  ttl                = 3600
}

module "cloudflare_cname_domainkey_2" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "xxx._domainkey"
  record_content     = "xxx.dkim.custom-email-domain.stripe.com."
  proxied            = false
  ttl                = 3600
}

module "cloudflare_cname_domainkey_3" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "xxx._domainkey"
  record_content     = "xxx.dkim.custom-email-domain.stripe.com."
  proxied            = false
  ttl                = 3600
}

module "cloudflare_cname_domainkey_4" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "xxx._domainkey"
  record_content     = "xxx.dkim.custom-email-domain.stripe.com."
  proxied            = false
  ttl                = 3600
}

module "cloudflare_cname_domainkey_5" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "xxx._domainkey"
  record_content     = "xxx.dkim.custom-email-domain.stripe.com."
  proxied            = false
  ttl                = 3600
}

module "cloudflare_cname_domainkey_6" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "xxx._domainkey"
  record_content     = "xxx.dkim.custom-email-domain.stripe.com."
  proxied            = false
  ttl                = 3600
}

module "cloudflare_cname_bounce" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = var.cloudflare_zone_id
  record_type        = "CNAME"
  record_name        = "bounce"
  record_content     = "custom-email-domain.stripe.com."
  proxied            = false
  ttl                = 3600
}

module "logs" {
  source                          = "../logs"
  environment                     = var.environment
  application_name                = var.application_name
  create_aws_cloudwatch_dashboard = false
}

module "ses" {
  source        = "../ses"
  email_address = var.ses_to_address
}

module "ssm_jwt_secret" {
  source      = "../ssm"
  name        = "/my/jwt_secret"
  value       = null
  description = "JWT secret for my auth."
}

module "ssm_github_api_key" {
  source      = "../ssm"
  name        = "/my/github_api_key"
  value       = null
  description = "GitHub personal access token for artifact cleaner Lambda."
}

module "ssm_mailerlite_api_key" {
  source      = "../ssm"
  name        = "/my/mailerlite_api_key"
  value       = null
  description = "Mailerlite API key for contact form Lambda."
}

module "ssm_hubspot_app_token" {
  source      = "../ssm"
  name        = "/my/hubspot_app_token"
  value       = null
  description = "HubSpot APP token for CRM management."
}

module "ssm_deepseek_api_key" {
  source      = "../ssm"
  name        = "/my/deepseek_api_key"
  value       = null
  description = "DeeepSeek API key for LLM integration."
}

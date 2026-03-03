// outputs.tf for shared module
output "s3_root" {
  value = module.s3_root.aws_s3_bucket
}

output "s3_www" {
  value = module.s3_www.aws_s3_bucket
}

output "s3_wwwdev" {
  value = module.s3_wwwdev.aws_s3_bucket
}

output "s3_uploads" {
  value = module.s3_uploads.aws_s3_bucket
}

output "s3_source" {
  value = module.s3_source.aws_s3_bucket
}

output "cloudflare_root_record_id" {
  value = module.cloudflare_root.dns_record_id
}

output "cloudflare_www_record_id" {
  value = module.cloudflare_www.dns_record_id
}

output "cloudflare_wwwdev_record_id" {
  value = module.cloudflare_wwwdev.dns_record_id
}

output "cloudflare_files_record_id" {
  value = module.cloudflare_files.dns_record_id
}

output "logs_group" {
  value = module.logs.log_group
}

output "ses_verified_email" {
  value = module.ses.verified_email
}

output "ssm_jwt_secret_name" {
  value = module.ssm_jwt_secret.name
}

output "ssm_github_api_key_name" {
  value = module.ssm_github_api_key.name
}

output "ssm_mailerlite_api_key_name" {
  value = module.ssm_mailerlite_api_key.name
}

output "ssm_hubspot_app_token_name" {
  value = module.ssm_hubspot_app_token.name
}

output "zone_id" {
  value = data.cloudflare_zone.this.id
}

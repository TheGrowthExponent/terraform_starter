output "dns_record_id" {
  description = "The ID of the created Cloudflare DNS record"
  value       = cloudflare_dns_record.this.id
}

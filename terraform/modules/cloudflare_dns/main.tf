# main.tf
#
# Module: cloudflare_dns
# Purpose: Creates a single Cloudflare DNS record.
# Inputs:
#   - cloudflare_zone_id: Cloudflare Zone ID
#   - record_type: DNS record type (A, AAAA, CNAME, etc.)
#   - record_name: DNS record name (e.g. www, @, api)
#   - record_content: DNS record content (IP address or hostname)
#   - proxied: Whether the record is proxied by Cloudflare
#   - ttl: Time to live for DNS record
#
# Outputs:
#   - dns_record_id: The ID of the created Cloudflare DNS record
#
# Notes:
#   - This module is intended for simple DNS record management.
#   - For advanced Cloudflare features, use a dedicated module.

resource "cloudflare_dns_record" "this" {
  zone_id = var.cloudflare_zone_id
  name    = var.record_name
  type    = var.record_type
  content = var.record_content
  proxied = var.proxied
  ttl     = var.ttl
}

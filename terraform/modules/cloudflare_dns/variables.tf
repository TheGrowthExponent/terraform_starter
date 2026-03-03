/**
 * variables.tf
 *
 * Purpose:
 *   Defines input variables for the cloudflare_dns Terraform module.
 *   This module manages a single Cloudflare DNS record.
 *
 * Inputs:
 *   - cloudflare_zone_id: Cloudflare Zone ID (string)
 *   - record_type: DNS record type (A, AAAA, CNAME, etc.) (string)
 *   - record_name: DNS record name (e.g. www, @, api) (string)
 *   - record_content: DNS record content (IP address or hostname) (string)
 *   - proxied: Whether the record is proxied by Cloudflare (bool, default: true)
 *   - ttl: Time to live for DNS record (number, default: 1)
 */

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "record_type" {
  description = "DNS record type (A, AAAA, CNAME, etc.)"
  type        = string
}

variable "record_name" {
  description = "DNS record name (e.g. www, @, api)"
  type        = string
}

variable "record_content" {
  description = "DNS record content (IP address or hostname)"
  type        = string
}

variable "proxied" {
  description = "Whether the record is proxied by Cloudflare"
  type        = bool
  default     = true
}

variable "ttl" {
  description = "Time to live for DNS record"
  type        = number
  default     = 1
}

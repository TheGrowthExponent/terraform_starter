# Cloudflare DNS Module

This module manages a single DNS record in a specified Cloudflare zone. It is designed to be reusable for creating, updating, or deleting DNS records such as CNAME, A, TXT, etc.

## Usage

```hcl
module "cloudflare_dns_record" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = "your-zone-id"
  record_type        = "CNAME"
  record_name        = "www"
  record_content     = "example.com"
  proxied            = true
  ttl                = 1
}
```

## Inputs

| Name               | Description                                         | Type        | Default | Required |
|--------------------|-----------------------------------------------------|-------------|---------|----------|
| cloudflare_zone_id | Cloudflare Zone ID                                  | string      | n/a     | yes      |
| record_type        | DNS record type (A, AAAA, CNAME, TXT, etc.)         | string      | n/a     | yes      |
| record_name        | DNS record name (e.g. www, @, api)                  | string      | n/a     | yes      |
| record_content     | DNS record content (IP address or hostname)         | string      | n/a     | yes      |
| proxied            | Whether the record is proxied by Cloudflare         | bool        | true    | no       |
| ttl                | Time to live for DNS record                         | number      | 1       | no       |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name         | Description                      |
|--------------|----------------------------------|
| record_id    | The ID of the created DNS record |
| record_name  | The name of the DNS record       |
| record_type  | The type of the DNS record       |

## Example

```hcl
module "cloudflare_dns_record" {
  source             = "../cloudflare_dns"
  cloudflare_zone_id = "your-zone-id"
  record_type        = "A"
  record_name        = "api"
  record_content     = "192.0.2.1"
  proxied            = false
  ttl                = 3600
}
```

## Notes

- This module is intended for use in a template repository. Customize variable values for your environment.
- Supports all standard Cloudflare DNS record types.
- The `proxied` flag determines whether traffic is routed through Cloudflare's proxy.
- The `ttl` value is in seconds. For proxied records, Cloudflare may enforce a minimum TTL.

## License

See the root LICENSE file for details.
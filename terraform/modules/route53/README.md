# Route53 Module

This module provisions AWS Route53 DNS records and related resources. It is designed to be reusable for managing DNS zones, records, and integrations with other AWS services.

## Usage

```hcl
module "route53" {
  source          = "../route53"
  hosted_zone_id  = "Z1234567890ABCDEF"
  host_name       = "example.com"
  load_balancer_dns_name = "my-load-balancer-1234567890.us-east-1.elb.amazonaws.com"
  load_balancer_zone_id  = "Z3DZXE0EXAMPLE"
  # cname_destination_url = "destination.example.com" # Uncomment if using CNAME records
}
```

## Inputs

| Name                   | Description                                 | Type         | Required | Default |
|------------------------|---------------------------------------------|--------------|----------|---------|
| hosted_zone_id         | The Route53 Hosted Zone ID                  | string       | yes      | n/a     |
| host_name              | The Route53 Host Name                       | string       | yes      | n/a     |
| load_balancer_dns_name | The DNS name of the Load Balancer           | string       | yes      | n/a     |
| load_balancer_zone_id  | The Zone ID of the Load Balancer            | string       | yes      | n/a     |
| cname_destination_url  | The CNAME destination URL (optional)        | string       | no       | n/a     |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name                  | Description                                  |
|-----------------------|----------------------------------------------|
| route53_record_name   | The name of the created Route53 record       |
| route53_record_type   | The type of the created Route53 record       |
| route53_record_value  | The value of the created Route53 record      |

## Example

```hcl
module "route53" {
  source                 = "../route53"
  hosted_zone_id         = "Z1234567890ABCDEF"
  host_name              = "example.com"
  load_balancer_dns_name = "my-load-balancer-1234567890.us-east-1.elb.amazonaws.com"
  load_balancer_zone_id  = "Z3DZXE0EXAMPLE"
}
```

## Notes

- This module is intended for use in a template repository. Customize variable values for your own domain and AWS resources.
- If you wish to create CNAME records, uncomment and set the `cname_destination_url` variable.
- Ensure your AWS credentials and permissions allow management of Route53 resources.

## License

See the root LICENSE file for details.
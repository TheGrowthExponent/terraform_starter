# ACM Module

This module provisions an AWS Certificate Manager (ACM) certificate for use with services such as API Gateway, Load Balancer, or CloudFront. It is designed to be reusable and configurable for different environments and domains.

## Usage

```hcl
module "acm" {
  source         = "../acm"
  hosted_zone_id = "Z1234567890ABCDEF"
  host_name      = "example.com"
}
```

## Inputs

| Name           | Description                   | Type   | Required | Default |
|----------------|-------------------------------|--------|----------|---------|
| hosted_zone_id | The Route53 Hosted Zone ID    | string | yes      | n/a     |
| host_name      | The Route53 Host Name         | string | yes      | n/a     |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name             | Description                      |
|------------------|----------------------------------|
| certificate_arn  | ARN of the ACM certificate       |
| domain_name      | The domain name for the certificate |

## Example

```hcl
module "acm" {
  source         = "../acm"
  hosted_zone_id = "Z1234567890ABCDEF"
  host_name      = "myapp.example.com"
}
```

## Notes

- Ensure the domain name is correctly configured in Route53 and that you have access to validate the certificate.
- This module is intended for use in a template repository. Customize variable values for your environment.

## License

See the root LICENSE file for details.
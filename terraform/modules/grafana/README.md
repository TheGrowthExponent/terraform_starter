# Grafana Module

This module provisions resources required for AWS-managed Grafana integration, including IAM roles and optional networking. It is designed to be reusable and configurable for different environments and applications.

## Usage

```hcl
module "grafana" {
  source            = "../grafana"
  application_name  = "my-app"
  environment       = "dev"
  grafana_role_arn  = "arn:aws:iam::123456789012:role/grafana-role"
  # sg_ids           = ["sg-0123456789abcdef0", "sg-0123456789abcdef1"] # Uncomment if needed
  # subnet_ids       = ["subnet-abc123", "subnet-def456"]               # Uncomment if needed
}
```

## Inputs

| Name             | Description                                 | Type          | Default   | Required |
|------------------|---------------------------------------------|---------------|-----------|----------|
| application_name | Name of the application.                    | string        | "example" | no       |
| environment      | Name of the environment.                    | string        | "dev"     | no       |
| grafana_role_arn | The ARN of the role to assume for Grafana.  | string        | n/a       | yes      |
| sg_ids           | The Security Group IDs.                     | list(string)  | n/a       | no       |
| subnet_ids       | The Subnet IDs.                             | list(string)  | n/a       | no       |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name           | Description                  |
|----------------|-----------------------------|
| grafana_url    | URL of the Grafana instance |
| grafana_role   | IAM role used for Grafana   |

## Example

```hcl
module "grafana" {
  source            = "../grafana"
  application_name  = "analytics"
  environment       = "prod"
  grafana_role_arn  = "arn:aws:iam::123456789012:role/grafana-prod-role"
}
```

## Notes

- Ensure the IAM role provided has the necessary permissions for Grafana integration.
- Security group and subnet IDs are optional and should be set if your Grafana instance requires specific networking.
- Adjust variable values as needed for your environment.

## License

See the root LICENSE file for details.

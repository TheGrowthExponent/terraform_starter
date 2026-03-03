# IAM Module

This module provisions AWS IAM resources such as roles, policies, and instance profiles. It is designed to be reusable and configurable for different environments and applications.

## Usage

```hcl
module "iam" {
  source      = "../iam"
  application_name = "my-app"
  environment      = "dev"
  account_id       = "123456789012"
  # Add other variables as needed
}
```

## Inputs

| Name         | Description                                         | Type     | Default   | Required |
|--------------|-----------------------------------------------------|----------|-----------|----------|
| application_name | Name of the application.                        | string   | "example" | no       |
| environment      | Name of the environment.                        | string   | "dev"     | no       |
| account_id       | AWS Account ID (must be 12 digits, numbers only)| string   | n/a       | yes      |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name           | Description                  |
|----------------|-----------------------------|
| role_arn       | ARN of the created IAM role |
| instance_profile | Name of the instance profile |

## Example

```hcl
module "iam" {
  source           = "../iam"
  application_name = "my-app"
  environment      = "prod"
  account_id       = "123456789012"
}
```

## Notes

- The `account_id` variable must be exactly 12 digits and contain only numbers.
- Customize the module to create roles, policies, and profiles as needed for your application.
- Sensitive values (such as account IDs) should be managed securely.

## License

See the root LICENSE file for details.

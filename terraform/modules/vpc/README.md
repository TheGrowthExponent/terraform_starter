# VPC Module

This module provisions an AWS Virtual Private Cloud (VPC) and related networking resources. It is designed to be reusable and configurable for different environments and applications.

## Usage

```hcl
module "vpc" {
  source            = "../vpc"
  application_name  = "my-app"
  environment       = "dev"
  # Uncomment and set these if importing an existing VPC
  # vpc_id           = "vpc-xxxxxxx"
  # public_subnets   = ["subnet-xxxxxxx", ...]
  # private_subnets  = ["subnet-yyyyyyy", ...]
}
```

## Inputs

| Name             | Description                                                                 | Type          | Default   | Required |
|------------------|-----------------------------------------------------------------------------|---------------|-----------|----------|
| application_name | Name of the application.                                                    | string        | "example" | no       |
| environment      | Name of the environment (max 8 chars, alphanumeric and hyphens only).       | string        | "dev"     | no       |
| vpc_id           | The VPC Id (if importing an existing VPC).                                  | string        | n/a       | no       |
| public_subnets   | The Public Subnet IDs (if importing an existing VPC).                       | list(string)  | n/a       | no       |
| private_subnets  | The Private Subnet IDs (if importing an existing VPC).                      | list(string)  | n/a       | no       |

## Outputs

| Name         | Description                      |
|--------------|----------------------------------|
| vpc_id       | The ID of the created VPC        |
| public_subnets  | List of public subnet IDs     |
| private_subnets | List of private subnet IDs    |

## Example

```hcl
module "vpc" {
  source           = "../vpc"
  application_name = "my-app"
  environment      = "prod"
}
```

## Notes

- If you wish to import an existing VPC, uncomment and set the `vpc_id`, `public_subnets`, and `private_subnets` variables.
- The `environment` variable must be no more than 8 characters and only contain letters, numbers, and hyphens.

## License

See the root LICENSE file for details.
# Secret Manager Module

This module provisions an AWS Secrets Manager secret with a description. It is designed to securely store sensitive information such as API keys, credentials, or configuration values.

## Usage

```hcl
module "secret_manager" {
  source              = "../secret_manager"
  secret_name         = "my-app-secret"
  secret_description  = "API key for external service"
}
```

## Inputs

| Name               | Description                        | Type   | Default      | Required |
|--------------------|------------------------------------|--------|--------------|----------|
| secret_name        | Name of the secret to be created   | string | "example"    | no       |
| secret_description | Description of the secret          | string | "My secret"  | no       |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name         | Description                      |
|--------------|----------------------------------|
| secret_arn   | ARN of the created secret        |
| secret_name  | Name of the created secret       |

## Example

```hcl
module "secret_manager" {
  source              = "../secret_manager"
  secret_name         = "prod-db-password"
  secret_description  = "Production database password"
}
```

## Notes

- Use this module to create secrets for storing sensitive values in AWS Secrets Manager.
- Make sure to grant appropriate IAM permissions to access the secret.
- Do not hardcode sensitive values in your Terraform configuration; use secure variable sources.

## License

See the root LICENSE file for details.
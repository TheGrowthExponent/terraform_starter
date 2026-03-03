# Prometheus Module

This module provisions resources required for Prometheus monitoring integration in your AWS environment. It is designed to be reusable and configurable for different applications and environments.

## Usage

```hcl
module "prometheus" {
  source      = "../prometheus"
  application_name = "my-app"
  environment      = "dev"
}
```

## Inputs

| Name             | Description                                   | Type    | Default   | Required |
|------------------|-----------------------------------------------|---------|-----------|----------|
| application_name | Name of the application.                      | string  | "example" | no       |
| environment      | Name of the environment.                      | string  | "dev"     | no       |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name           | Description                  |
|----------------|-----------------------------|
| prometheus_url | URL of the Prometheus server |

## Example

```hcl
module "prometheus" {
  source           = "../prometheus"
  application_name = "my-app"
  environment      = "prod"
}
```

## Notes

- The `application_name` and `environment` variables help organize and tag resources for Prometheus monitoring.
- Customize variable values as needed for your environment.
- Review the module's resources to ensure they meet your monitoring requirements.

## License

See the root LICENSE file for details.
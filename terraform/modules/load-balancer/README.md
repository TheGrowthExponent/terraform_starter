# Load Balancer Module

This module provisions an AWS Load Balancer and related networking resources. It is designed to be reusable and configurable for different environments and applications.

## Usage

```hcl
module "load_balancer" {
  source                = "../load-balancer"
  application_name      = "my-app"
  environment           = "dev"
  load_balancer_sg_id   = "sg-0123456789abcdef0"
  vpc_id                = "vpc-0123456789abcdef0"
  private_subnets       = ["subnet-0123456789abcdef1", "subnet-0123456789abcdef2"]
  certificate_arn       = "arn:aws:acm:us-east-1:123456789012:certificate/abcdefg"
  authorization_endpoint = "https://login.microsoftonline.com/oauth2/authorize"
  client_id             = "your-client-id"
  client_secret         = "your-client-secret"
  issuer                = "https://sts.windows.net/your-tenant-id/"
  token_endpoint        = "https://login.microsoftonline.com/oauth2/token"
  user_info_endpoint    = "https://graph.microsoft.com/v1.0/me"
  internal              = true
}
```

## Inputs

| Name                      | Description                                         | Type         | Default   | Required |
|---------------------------|-----------------------------------------------------|--------------|-----------|----------|
| application_name          | Name of the application.                            | string       | "example" | no       |
| environment               | Name of the environment.                            | string       | "dev"     | no       |
| load_balancer_sg_id       | Security Group for the Load Balancer                | string       | n/a       | yes      |
| vpc_id                    | The VPC Id                                         | string       | n/a       | yes      |
| private_subnets           | The Private Subnet IDs                              | list(string) | n/a       | yes      |
| certificate_arn           | ACM certificate                                    | string       | n/a       | yes      |
| authorization_endpoint    | Azure AAD authorization endpoint                    | string       | n/a       | yes      |
| client_id                 | Azure AAD client id                                | string       | n/a       | yes      |
| client_secret             | Azure AAD client secret                            | string       | n/a       | yes      |
| issuer                    | Azure AAD issuer                                   | string       | n/a       | yes      |
| token_endpoint            | Azure AAD token endpoint                           | string       | n/a       | yes      |
| user_info_endpoint        | Azure AAD user info endpoint                       | string       | n/a       | yes      |
| internal                  | Internal or External Load Balancer                  | bool         | true      | no       |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name                | Description                        |
|---------------------|------------------------------------|
| load_balancer_arn   | ARN of the created Load Balancer   |
| dns_name            | DNS name of the Load Balancer      |

## Example

```hcl
module "load_balancer" {
  source                = "../load-balancer"
  application_name      = "my-app"
  environment           = "prod"
  load_balancer_sg_id   = "sg-0123456789abcdef0"
  vpc_id                = "vpc-0123456789abcdef0"
  private_subnets       = ["subnet-0123456789abcdef1", "subnet-0123456789abcdef2"]
  certificate_arn       = "arn:aws:acm:us-east-1:123456789012:certificate/abcdefg"
  authorization_endpoint = "https://login.microsoftonline.com/oauth2/authorize"
  client_id             = "your-client-id"
  client_secret         = "your-client-secret"
  issuer                = "https://sts.windows.net/your-tenant-id/"
  token_endpoint        = "https://login.microsoftonline.com/oauth2/token"
  user_info_endpoint    = "https://graph.microsoft.com/v1.0/me"
  internal              = false
}
```

## Notes

- The `internal` variable determines whether the Load Balancer is internal or external.
- Ensure that the security group and subnet IDs match your VPC setup.
- The module supports integration with Azure Active Directory for authentication.

## License

See the root LICENSE file for details.
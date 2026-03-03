# EC2 Module

This module provisions an AWS EC2 instance with configurable networking, security, and storage options. It is designed to be reusable and flexible for different environments and applications.

## Usage

```hcl
module "ec2_instance" {
  source                = "../ec2"
  application_name      = "my-app"
  environment           = "dev"
  instance_name         = "web-server"
  ami                   = "ami-0123456789abcdef0"
  public_key            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDc9vCDIU2sxtYwkhIm+UdAHrYNCpI9spHLcSoCEoNKDaSLDxs7Uxefk2bxZBxJD205Zg5opAXT23gJKkvyK5E+KJG9la34WWQlb6BpWrjomiON9zDn3epthE4J/IpaR4b2yphqd6ucb9QbBrT7fatLf/oNg1MXZsenG0Vizc/6eCprMm2RYa5g72HvrMMFZT0jTE7QoIK/3RFkIWS9sTDbKpFt4jjql2Leu3iaXyALVUF6U5DPFciHGhJy9zsE0tuqj5YqtFKnU12e6rjJihXjEvGeztJvRv8DfVIxrqaFPgG/XicW5qg5nm/pAF820pUX8XG1RK03JCMtL3f5wGKczJXTrFkePA1dkirkY2kdIEsLEVigbIXB0vvkU7QIS+i6ji+B8RxvpXm9qC+GxDoWew9EefMXvSdG/dKw1XD6IdlXgswxSOM0hMhrcSYaae8ukVkwmeTxsSTvdKXvdgdvhsSnGpl78PM0TqRFWeY1APnI1n4LNcI/pq5Gg0OF4vEo admin@server.local"
  private_subnet_id     = "subnet-abc123"
  ec2_instance_profile  = "my-instance-profile"
  sg_id                 = "sg-0123456789abcdef0"
  volume_size           = 16
  user_data             = ""
  create_ec2_instance   = true
}
```

## Inputs

| Name                | Description                                         | Type         | Default                | Required |
|---------------------|-----------------------------------------------------|--------------|------------------------|----------|
| application_name    | Name of the application.                            | string       | "example"              | no       |
| environment         | Name of the environment.                            | string       | "dev"                  | no       |
| instance_name       | Name of the instance.                               | string       | "example instance"     | no       |
| ami                 | The AMI to use for the instance.                    | string       | n/a                    | yes      |
| public_key          | The public key to use for the instance.             | string       | see variables.tf       | no       |
| private_subnet_id   | The ID of the private subnet.                       | string       | n/a                    | yes      |
| ec2_instance_profile| The instance profile to use for the instance.       | string       | n/a                    | yes      |
| sg_id               | The security group to use for the instance.         | string       | n/a                    | yes      |
| volume_size         | The size of the volume in GB.                       | number       | 8                      | no       |
| user_data           | The user data to use for the instance.              | string       | ""                     | no       |
| create_ec2_instance | Whether to create the EC2 instance.                 | bool         | false                  | no       |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name           | Description                  |
|----------------|-----------------------------|
| instance_id    | The ID of the created EC2 instance |
| public_ip      | The public IP address (if applicable) |
| private_ip     | The private IP address      |

## Example

```hcl
module "ec2_instance" {
  source                = "../ec2"
  application_name      = "my-app"
  environment           = "prod"
  instance_name         = "app-server"
  ami                   = "ami-0abcdef1234567890"
  public_key            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDc9vCDIU2sxtYwkhIm+UdAHrYNCpI9spHLcSoCEoNKDaSLDxs7Uxefk2bxZBxJD205Zg5opAXT23gJKkvyK5E+KJG9la34WWQlb6BpWrjomiON9zDn3epthE4J/IpaR4b2yphqd6ucb9QbBrT7fatLf/oNg1MXZsenG0Vizc/6eCprMm2RYa5g72HvrMMFZT0jTE7QoIK/3RFkIWS9sTDbKpFt4jjql2Leu3iaXyALVUF6U5DPFciHGhJy9zsE0tuqj5YqtFKnU12e6rjJihXjEvGeztJvRv8DfVIxrqaFPgG/XicW5qg5nm/pAF820pUX8XG1RK03JCMtL3f5wGKczJXTrFkePA1dkirkY2kdIEsLEVigbIXB0vvkU7QIS+i6ji+B8RxvpXm9qC+GxDoWew9EefMXvSdG/dKw1XD6IdlXgswxSOM0hMhrcSYaae8ukVkwmeTxsSTvdKXvdgdvhsSnGpl78PM0TqRFWeY1APnI1n4LNcI/pq5Gg0OF4vEo admin@server.local"
  private_subnet_id     = "subnet-xyz789"
  ec2_instance_profile  = "prod-instance-profile"
  sg_id                 = "sg-abcdef1234567890"
  volume_size           = 32
  user_data             = ""
  create_ec2_instance   = true
}
```

## Notes

- The `create_ec2_instance` variable allows you to conditionally create the EC2 instance.
- Make sure the AMI, subnet, security group, and instance profile are valid for your AWS account and region.
- The public key should be in SSH format and match your access requirements.

## License

See the root LICENSE file for details.
# RDS Module

This module provisions an AWS RDS (Relational Database Service) instance, supporting configuration for engine, version, networking, and security. It is designed to be flexible for various database workloads and environments.

## Usage

```hcl
module "rds" {
  source                = "../rds"
  db_name               = "mydb"
  instance_class        = "db.serverless"
  engine                = "aurora-postgresql"
  engine_mode           = "provisioned"
  engine_version        = "16"
  db_admin_user         = var.db_admin_user
  db_subnet_group_name  = "my-subnet-group"
  subnet_ids            = ["subnet-abc123", "subnet-def456"]
  vpc_security_group_ids = ["sg-0123456789abcdef0"]
}
```

## Inputs

| Name                  | Description                                                                                                         | Type         | Default           | Required |
|-----------------------|---------------------------------------------------------------------------------------------------------------------|--------------|-------------------|----------|
| db_name               | Name of RDS DB instance                                                                                             | string       | n/a               | yes      |
| instance_class        | The instance type to use. `db.serverless` is only available for Aurora.                                             | string       | "db.serverless"   | no       |
| engine                | The database engine to use.                                                                                         | string       | "aurora-postgresql"| no      |
| engine_mode           | The database engine mode to use.                                                                                    | string       | "provisioned"     | no       |
| engine_version        | The version of the database engine to use.                                                                          | string       | "16"              | no       |
| db_admin_user         | Backend database admin username. Should be retrieved from a secure secret store.                                    | string       | n/a               | yes      |
| db_subnet_group_name  | Name of subnet group for RDS                                                                                        | string       | n/a               | yes      |
| subnet_ids            | Subnets to allow access to RDS                                                                                      | list(string) | n/a               | yes      |
| vpc_security_group_ids| List of VPC security groups to associate to RDS                                                                     | list(string) | n/a               | yes      |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name         | Description                      |
|--------------|----------------------------------|
| rds_endpoint | The endpoint of the RDS instance |
| rds_arn      | The ARN of the RDS instance      |

## Example

```hcl
module "rds" {
  source                = "../rds"
  db_name               = "appdb"
  instance_class        = "db.t3.medium"
  engine                = "aurora-mysql"
  engine_mode           = "serverless"
  engine_version        = "8.0"
  db_admin_user         = var.db_admin_user
  db_subnet_group_name  = "app-subnet-group"
  subnet_ids            = ["subnet-12345678", "subnet-87654321"]
  vpc_security_group_ids = ["sg-abcdef12", "sg-1234abcd"]
}
```

## Notes

- The `db_admin_user` variable should be set securely, ideally from a secret manager or environment variable.
- Adjust `engine`, `engine_mode`, and `engine_version` to match your workload requirements.
- Ensure subnet IDs and security groups are correctly configured for your VPC.

## License

See the root LICENSE file for details.
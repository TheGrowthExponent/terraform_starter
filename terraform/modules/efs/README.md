# EFS Module

This module provisions an AWS Elastic File System (EFS) and related resources, including mount targets and lifecycle policies. It is designed to be reusable and configurable for different environments and applications.

## Usage

```hcl
module "efs" {
  source              = "../efs"
  efs_name            = "my-efs"
  transition_to_ia    = "AFTER_7_DAYS"
  private_subnets     = ["subnet-abc123", "subnet-def456"]
  shared_efs_sg_id    = "sg-0123456789abcdef0"
  ec2_role_arn        = "arn:aws:iam::123456789012:role/efs-role"
  resource_tags = {
    owner   = "team"
    purpose = "shared-storage"
  }
}
```

## Inputs

| Name              | Description                                         | Type         | Default         | Required |
|-------------------|-----------------------------------------------------|--------------|-----------------|----------|
| efs_name          | Name of the EFS file system                         | string       | n/a             | yes      |
| transition_to_ia  | Lifecycle policy for EFS (e.g., AFTER_7_DAYS)       | string       | "AFTER_7_DAYS"  | no       |
| private_subnets   | Private subnets for EFS mount targets               | list(string) | n/a             | yes      |
| shared_efs_sg_id  | Security group ID for the EFS file system           | string       | n/a             | yes      |
| ec2_role_arn      | ARN of the IAM role to attach the policy to         | string       | n/a             | yes      |
| resource_tags     | Tags to set for all resources                       | map(string)  | n/a             | yes      |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name         | Description                        |
|--------------|------------------------------------|
| efs_id       | The ID of the created EFS          |
| mount_targets| List of EFS mount target IDs       |

## Example

```hcl
module "efs" {
  source              = "../efs"
  efs_name            = "shared-efs"
  transition_to_ia    = "AFTER_14_DAYS"
  private_subnets     = ["subnet-abc123", "subnet-def456"]
  shared_efs_sg_id    = "sg-0123456789abcdef0"
  ec2_role_arn        = "arn:aws:iam::123456789012:role/efs-role"
  resource_tags = {
    owner   = "devops"
    purpose = "shared-storage"
  }
}
```

## Notes

- The `transition_to_ia` variable controls when files are moved to Infrequent Access storage.
- Ensure that the security group allows NFS traffic (port 2049) between your EC2 instances and EFS.
- The IAM role should have permissions for EFS access if used with EC2.

## License

See the root LICENSE file for details.

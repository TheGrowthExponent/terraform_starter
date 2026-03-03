# Auto-Scaling Module

This module provisions AWS Auto Scaling resources for EC2 or ECS workloads. It is designed to be flexible and configurable for different environments and scaling requirements.

## Usage

```hcl
module "auto_scaling" {
  source                    = "../auto-scaling"
  application_name          = "my-app"
  environment               = "dev"
  ecs_target_group_arn      = "arn:aws:elasticloadbalancing:region:account-id:targetgroup/target-group-name/abc123"
  private_subnets           = ["subnet-abc123", "subnet-def456"]
  sg_id                     = "sg-0123456789abcdef0"
  ecs_role_arn              = "arn:aws:iam::123456789012:role/ecs-role"
  aws_key                   = "my-key"
  log_group_name            = "my-app-logs"
  aws_ami                   = "ami-0123456789abcdef0"
  aws_ecr_repository_repository_url = "123456789012.dkr.ecr.region.amazonaws.com/my-repo"
  aws_ecr_repository_version = "latest"
  cpu                       = 256
  memory                    = 512
  sns_notifications_topic_arn = "arn:aws:sns:region:account-id:my-topic"
  region                    = "us-east-1"
  asg_max_size              = 3
  asg_min_size              = 1
  maximum_scaling_step_size = 1
  minimum_scaling_step_size = 1
  target_capacity           = 2
  s3_bucket_name            = "my-app-bucket"
}

```

## Inputs

| Name                        | Description                                         | Type         | Default   | Required |
|-----------------------------|-----------------------------------------------------|--------------|-----------|----------|
| application_name            | Name of the application.                            | string       | "example" | no       |
| environment                 | Name of the environment.                            | string       | "dev"     | no       |
| ecs_target_group_arn        | The ECS Target Group ARN                            | string       | n/a       | yes      |
| private_subnets             | The Private Subnet IDs                              | list(string) | n/a       | yes      |
| sg_id                       | The Security Group                                  | string       | n/a       | yes      |
| ecs_role_arn                | The ECS Role ARN                                    | string       | n/a       | yes      |
| aws_key                     | The AWS Key                                         | string       | n/a       | yes      |
| log_group_name              | The Log Group                                       | string       | n/a       | yes      |
| aws_ami                     | The AMI                                             | string       | n/a       | yes      |
| aws_ecr_repository_repository_url | The ECR Repository URL                        | string       | n/a       | yes      |
| aws_ecr_repository_version  | The ECR Repository Version                          | string       | "latest"  | no       |
| cpu                         | The CPU of ECS Task                                 | number       | 256       | no       |
| memory                      | The Memory of ECS Task                              | number       | 512       | no       |
| sns_notifications_topic_arn | The SNS Notifications Topic                         | string       | n/a       | yes      |
| region                      | The region                                          | string       | "us-east-1"| no      |
| asg_max_size                | max_size                                            | number       | 1         | no       |
| asg_min_size                | min_size                                            | number       | 1         | no       |
| maximum_scaling_step_size   | maximum_scaling_step_size                           | number       | 1         | no       |
| minimum_scaling_step_size   | minimum_scaling_step_size                           | number       | 1         | no       |
| target_capacity             | target_capacity                                     | number       | 1         | no       |
| s3_bucket_name              | The S3 Bucket                                       | string       | n/a       | yes      |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name           | Description                  |
|----------------|-----------------------------|
| asg_id         | The ID of the Auto Scaling Group |
| asg_arn        | The ARN of the Auto Scaling Group |
| scaling_policy | The scaling policy resource  |

## Example

```hcl
module "auto_scaling" {
  source           = "../auto-scaling"
  application_name = "my-app"
  environment      = "prod"
  ecs_target_group_arn = "arn:aws:elasticloadbalancing:region:account-id:targetgroup/target-group-name/abc123"
  private_subnets  = ["subnet-abc123", "subnet-def456"]
  sg_id            = "sg-0123456789abcdef0"
  ecs_role_arn     = "arn:aws:iam::123456789012:role/ecs-role"
  aws_key          = "my-key"
  log_group_name   = "my-app-logs"
  aws_ami          = "ami-0123456789abcdef0"
  aws_ecr_repository_repository_url = "123456789012.dkr.ecr.region.amazonaws.com/my-repo"
  aws_ecr_repository_version = "latest"
  cpu              = 256
  memory           = 512
  sns_notifications_topic_arn = "arn:aws:sns:region:account-id:my-topic"
  region           = "us-east-1"
  asg_max_size     = 5
  asg_min_size     = 2
  maximum_scaling_step_size = 2
  minimum_scaling_step_size = 1
  target_capacity  = 3
  s3_bucket_name   = "my-app-bucket"
}
```

## Notes

- Adjust scaling parameters (`asg_max_size`, `asg_min_size`, etc.) to fit your workload requirements.
- Ensure IAM roles and security groups are properly configured for your environment.
- The module is designed to be generic and reusable for different applications and environments.

## License

See the root LICENSE file for details.
# ECS Module

This module provisions an AWS ECS (Elastic Container Service) cluster and related resources for running containerized workloads. It is designed to be reusable and configurable for different environments and applications.

## Usage

```hcl
module "ecs" {
  source                   = "../ecs"
  application_name         = "my-app"
  environment              = "dev"
  ecs_target_group_arn     = "arn:aws:elasticloadbalancing:region:account-id:targetgroup/target-group-name/1234567890abcdef"
  private_subnets          = ["subnet-abc123", "subnet-def456"]
  sg_id                    = "sg-0123456789abcdef0"
  ecs_role_arn             = "arn:aws:iam::123456789012:role/ecs-role"
  aws_key                  = "my-key"
  log_group_name           = "my-app-log-group"
  aws_ami                  = "ami-0123456789abcdef0"
  aws_ecr_repository_repository_url = "123456789012.dkr.ecr.region.amazonaws.com/my-repo"
  sns_notifications_topic_arn = "arn:aws:sns:region:account-id:my-topic"
  # Optional values
  aws_ecr_repository_version = "latest"
  cpu                        = 256
  memory                     = 512
  region                     = "us-east-1"
  asg_max_size               = 1
  asg_min_size               = 1
  maximum_scaling_step_size  = 1
  minimum_scaling_step_size  = 1
  target_capacity            = 1
  s3_bucket_name             = "my-app-bucket"
}
```

## Inputs

| Name                         | Description                                 | Type         | Default   | Required |
|------------------------------|---------------------------------------------|--------------|-----------|----------|
| application_name             | Name of the application.                    | string       | "example" | no       |
| environment                  | Name of the environment.                    | string       | "dev"     | no       |
| ecs_target_group_arn         | The ECS Target Group ARN                    | string       | n/a       | yes      |
| private_subnets              | The Private Subnet IDs                      | list(string) | n/a       | yes      |
| sg_id                        | The Security Group                          | string       | n/a       | yes      |
| ecs_role_arn                 | The ECS Role ARN                            | string       | n/a       | yes      |
| aws_key                      | The AWS Key                                 | string       | n/a       | yes      |
| log_group_name               | The Log Group                               | string       | n/a       | yes      |
| aws_ami                      | The AMI                                     | string       | n/a       | yes      |
| aws_ecr_repository_repository_url | The ECR Repository URL                 | string       | n/a       | yes      |
| aws_ecr_repository_version   | The ECR Repository Version                  | string       | "latest"  | no       |
| cpu                          | The CPU of ECS Task                         | number       | 256       | no       |
| memory                       | The Memory of ECS Task                      | number       | 512       | no       |
| sns_notifications_topic_arn  | The SNS Notifications Topic                 | string       | n/a       | yes      |
| region                       | The region                                  | string       | "us-east-1"| no      |
| asg_max_size                 | max_size                                    | number       | 1         | no       |
| asg_min_size                 | min_size                                    | number       | 1         | no       |
| maximum_scaling_step_size    | maximum_scaling_step_size                   | number       | 1         | no       |
| minimum_scaling_step_size    | minimum_scaling_step_size                   | number       | 1         | no       |
| target_capacity              | target_capacity                             | number       | 1         | no       |
| s3_bucket_name               | The S3 Bucket                               | string       | n/a       | yes      |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name         | Description                      |
|--------------|----------------------------------|
| ecs_cluster_id | The ID of the created ECS cluster |
| ecs_service_name | Name of the ECS service         |

## Example

```hcl
module "ecs" {
  source                   = "../ecs"
  application_name         = "my-app"
  environment              = "prod"
  ecs_target_group_arn     = "arn:aws:elasticloadbalancing:region:account-id:targetgroup/target-group-name/1234567890abcdef"
  private_subnets          = ["subnet-abc123", "subnet-def456"]
  sg_id                    = "sg-0123456789abcdef0"
  ecs_role_arn             = "arn:aws:iam::123456789012:role/ecs-role"
  aws_key                  = "my-key"
  log_group_name           = "my-app-log-group"
  aws_ami                  = "ami-0123456789abcdef0"
  aws_ecr_repository_repository_url = "123456789012.dkr.ecr.region.amazonaws.com/my-repo"
  sns_notifications_topic_arn = "arn:aws:sns:region:account-id:my-topic"
  s3_bucket_name           = "my-app-bucket"
}
```

## Notes

- The `environment` variable must be no more than 8 characters and only contain letters, numbers, and hyphens.
- Make sure all ARNs and resource IDs are valid for your AWS account and region.
- Adjust CPU, memory, and scaling parameters as needed for your workload.

## License

See the root LICENSE file for details.
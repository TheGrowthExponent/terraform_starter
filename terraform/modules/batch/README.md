# Batch Module

This module provisions AWS Batch resources, including compute environments, job definitions, and related networking and IAM roles. It is designed to be flexible for different environments and workloads.

## Usage

```hcl
module "batch" {
  source                      = "../batch"
  subnet_ids                  = ["subnet-abc123", "subnet-def456"]
  aws_ecr_repository_url      = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-repo"
  aws_ecr_repository_version  = "latest"
  ecs_instance_role_arn       = "arn:aws:iam::123456789012:role/ecs-instance-role"
  batch_service_role_arn      = "arn:aws:iam::123456789012:role/batch-service-role"
  ecs_task_execution_role_arn = "arn:aws:iam::123456789012:role/ecs-task-execution-role"
  vcpu                        = 1
  memory                      = 2048
  s3_bucket_name              = "my-batch-bucket"
  batch_name                  = "my-batch-job"
  compute_environment         = "FARGATE"
  security_group_ids          = ["sg-0123456789abcdef0"]
}
```

## Inputs

| Name                      | Description                                   | Type          | Default   | Required |
|---------------------------|-----------------------------------------------|---------------|-----------|----------|
| subnet_ids                | The Private Subnet IDs                        | list(string)  | n/a       | yes      |
| aws_ecr_repository_url    | The name of the ECR repository                | string        | n/a       | yes      |
| aws_ecr_repository_version| The version of the ECR repository             | string        | "latest"  | no       |
| ecs_instance_role_arn     | ECS Instance Role ARN                         | string        | n/a       | yes      |
| batch_service_role_arn    | Batch Service Role ARN                        | string        | n/a       | yes      |
| ecs_task_execution_role_arn| ECS Task Execution Role ARN                  | string        | n/a       | yes      |
| vcpu                      | The vCPU of ECS Task                          | number        | 0.25      | no       |
| memory                    | The Memory of ECS Task                        | number        | 512       | no       |
| s3_bucket_name            | S3 Bucket Name                                | string        | n/a       | yes      |
| batch_name                | The name of the batch job definition          | string        | n/a       | yes      |
| compute_environment       | The compute environment type                  | string        | "FARGATE" | no       |
| security_group_ids        | The security group ids of the batch job       | list(string)  | n/a       | yes      |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name           | Description                  |
|----------------|-----------------------------|
| batch_job_arn  | ARN of the created Batch job |
| compute_env_id | ID of the compute environment|

## Example

```hcl
module "batch" {
  source                      = "../batch"
  subnet_ids                  = ["subnet-abc123", "subnet-def456"]
  aws_ecr_repository_url      = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-repo"
  aws_ecr_repository_version  = "latest"
  ecs_instance_role_arn       = "arn:aws:iam::123456789012:role/ecs-instance-role"
  batch_service_role_arn      = "arn:aws:iam::123456789012:role/batch-service-role"
  ecs_task_execution_role_arn = "arn:aws:iam::123456789012:role/ecs-task-execution-role"
  vcpu                        = 1
  memory                      = 2048
  s3_bucket_name              = "my-batch-bucket"
  batch_name                  = "my-batch-job"
  compute_environment         = "FARGATE"
  security_group_ids          = ["sg-0123456789abcdef0"]
}
```

---

**Note:**
- Ensure IAM roles have the necessary permissions for Batch, ECS, and ECR operations.
- Adjust vCPU and memory values to match your workload requirements.
- Security group IDs should allow necessary traffic for Batch jobs.

---

## License

See the root LICENSE file for details.

# Lambda Module

This module provisions an AWS Lambda function with configurable networking, IAM role, S3 bucket integration, and environment variables.

## Usage

```hcl
module "lambda" {
  source              = "../lambda"
  function_name       = "my_lambda_function"
  src_path            = "./src"
  lambda_role_arn     = aws_iam_role.lambda_role.arn
  subnet_ids          = [aws_subnet.private1.id, aws_subnet.private2.id]
  load_balancer_sg_id = aws_security_group.lb_sg.id
  queue_arn           = aws_sqs_queue.my_queue.arn
  bucket_arn          = aws_s3_bucket.my_bucket.arn
  lambda_memory_size  = 512
  lambda_timeout      = 60
  env_vars = {
    ENVIRONMENT = "dev"
    LOG_LEVEL   = "info"
  }
}
```

## Inputs

| Name                | Description                                                                 | Type         | Default  | Required |
|---------------------|-----------------------------------------------------------------------------|--------------|----------|----------|
| function_name       | The name of the Lambda function                                             | string       | n/a      | yes      |
| src_path            | Path to the lambda function code                                            | string       | n/a      | yes      |
| lambda_role_arn     | IAM role ARN for Lambda execution                                           | string       | n/a      | yes      |
| subnet_ids          | Subnet IDs for Lambda networking                                            | list(string) | n/a      | yes      |
| load_balancer_sg_id | Security Group ID for the Load Balancer                                     | string       | n/a      | yes      |
| queue_arn           | ARN of the SQS queue                                                        | string       | n/a      | yes      |
| bucket_arn          | ARN of the S3 bucket                                                        | string       | n/a      | yes      |
| lambda_memory_size  | Memory size (MB) for the Lambda function                                    | string       | 256      | no       |
| lambda_timeout      | Timeout (seconds) for the Lambda function                                   | string       | 30       | no       |
| env_vars            | Environment variables for the Lambda function                               | map(string)  | {}       | no       |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name           | Description                  |
|----------------|-----------------------------|
| lambda_arn     | ARN of the created Lambda    |
| lambda_name    | Name of the Lambda function  |

## Example

See the [Usage](#usage) section above for a basic example. Adjust the variable values as needed for your environment.

---

**Note:**
- Ensure IAM role permissions are sufficient for Lambda execution and access to referenced resources.
- The `src_path` should point to your Lambda source code directory.
- Networking and security group IDs should match your VPC setup.

---

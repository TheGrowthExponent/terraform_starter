# SQS Module

This module provisions an AWS SQS queue with configurable name and visibility timeout. It is designed to be reusable for different applications and environments.

## Usage

```hcl
module "sqs" {
  source                      = "../sqs"
  queue_name                  = "my-queue"
  visibility_timeout_seconds  = "45"
}
```

## Inputs

| Name                      | Description                        | Type    | Default | Required |
|---------------------------|------------------------------------|---------|---------|----------|
| queue_name                | Name of the SQS queue              | string  | n/a     | yes      |
| visibility_timeout_seconds| The visibility timeout for the queue| string  | "30"    | no       |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name        | Description                  |
|-------------|-----------------------------|
| queue_url   | The URL of the created queue|
| queue_arn   | The ARN of the created queue|

## Example

```hcl
module "sqs" {
  source                      = "../sqs"
  queue_name                  = "orders-queue"
  visibility_timeout_seconds  = "60"
}
```

## Notes

- The `visibility_timeout_seconds` controls how long a message is hidden after being retrieved from the queue.
- Make sure to configure IAM permissions for any resources that need to interact with the queue.

## License

See the root LICENSE file for details.

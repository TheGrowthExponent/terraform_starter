# Event Bridge Module

This module provisions an AWS EventBridge rule and target for scheduling Lambda invocations. It is designed to automate periodic tasks using CloudWatch Events and Lambda integration.

## Usage

```hcl
module "event_bridge" {
  source                = "../event-bridge"
  scheduler_name        = "daily-job"
  rate                  = "rate(24 hours)"
  lambda_function_name  = "my_lambda_function"
  lambda_function_arn   = aws_lambda_function.my_lambda.arn
}
```

## Inputs

| Name                 | Description                                   | Type   | Default         | Required |
|----------------------|-----------------------------------------------|--------|-----------------|----------|
| scheduler_name       | The name of the CloudWatch Event Rule         | string | n/a             | yes      |
| rate                 | The rate at which the rule should be triggered| string | "rate(24 hours)"| no       |
| lambda_function_name | The name of the Lambda function               | string | n/a             | yes      |
| lambda_function_arn  | The ARN of the Lambda function                | string | n/a             | yes      |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name                | Description                        |
|---------------------|------------------------------------|
| event_rule_arn      | ARN of the created EventBridge rule|
| event_target_id     | ID of the EventBridge target       |

## Example

```hcl
module "event_bridge" {
  source                = "../event-bridge"
  scheduler_name        = "hourly-job"
  rate                  = "rate(1 hour)"
  lambda_function_name  = "process_data"
  lambda_function_arn   = aws_lambda_function.process_data.arn
}
```

---

**Notes:**
- The `rate` input should follow the CloudWatch Events rate expression format (e.g., "rate(5 minutes)", "rate(1 day)").
- Ensure the Lambda function's IAM role allows invocation by EventBridge.
- You may add additional targets or event patterns as needed for your use case.

---

## License

See the root LICENSE file for details.

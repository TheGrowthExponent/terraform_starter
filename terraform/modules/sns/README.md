# SNS Module

This module provisions an AWS Simple Notification Service (SNS) topic and configures notification recipients. It is designed to be reusable for sending alerts, notifications, or integrating with other AWS services.

## Usage

```hcl
module "sns" {
  source                  = "../sns"
  account_id              = "123456789012"
  topic_name              = "alerts-topic"
  notification_recipients = ["user1@example.com", "user2@example.com"]
}
```

## Inputs

| Name                   | Description                                      | Type         | Default | Required |
|------------------------|--------------------------------------------------|--------------|---------|----------|
| account_id             | AWS Account ID                                   | string       | n/a     | yes      |
| topic_name             | The name of the SNS topic                        | string       | n/a     | yes      |
| notification_recipients| Email address list of notification recipients    | list(string) | n/a     | yes      |

## Outputs

_Outputs should be documented here if the module provides any. Example:_

| Name         | Description                      |
|--------------|----------------------------------|
| topic_arn    | ARN of the created SNS topic     |
| topic_name   | Name of the SNS topic            |

## Example

```hcl
module "sns" {
  source                  = "../sns"
  account_id              = "123456789012"
  topic_name              = "critical-alerts"
  notification_recipients = ["admin@example.com", "ops@example.com"]
}
```

---

**Notes:**
- Ensure the provided AWS Account ID is correct and matches your environment.
- Notification recipients should be valid email addresses.
- The module can be extended to support SMS, Lambda, or other endpoints.

---

## License

See the root LICENSE file for details.

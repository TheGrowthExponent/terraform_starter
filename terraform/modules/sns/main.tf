resource "aws_sns_topic" "notifications" {
  name = "notification-topic-${var.application_name}-${var.environment}"
}

resource "aws_sns_topic" "error_notifications" {
  name = "error-notification-topic-${var.application_name}-${var.environment}"
}

resource "aws_sns_topic_policy" "sns_error_topic_policy" {
  arn    = aws_sns_topic.error_notifications.arn
  policy = data.aws_iam_policy_document.sns_error_topic_policy.json
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = aws_sns_topic.notifications.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "sns_email_target" {
  for_each  = toset(var.notification_recipients)
  topic_arn = aws_sns_topic.error_notifications.arn
  protocol  = "email"
  endpoint  = each.value
}
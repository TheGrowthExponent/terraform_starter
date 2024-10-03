resource "aws_sns_topic" "notifications" {
  name = var.topic_name
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = aws_sns_topic.notifications.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "sns_email_target" {
  for_each  = toset(var.notification_recipients)
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "email"
  endpoint  = each.value
}

output "sns_notifications_topic" {
  description = "sns_notifications_topic"
  value       = aws_sns_topic.notifications
}

output "sns_error_notifications_topic" {
  description = "sns_error_notifications_topic"
  value       = aws_sns_topic.error_notifications
}

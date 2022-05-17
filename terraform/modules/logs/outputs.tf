output "aws_cloudwatch_log_group" {
  description = "aws_cloudwatch_log_group"
  value       = aws_cloudwatch_log_group.example.id
}

output "aws_cloudwatch_log_group_arn" {
  description = "aws_cloudwatch_log_group_arn"
  value       = aws_cloudwatch_log_group.example.arn
}
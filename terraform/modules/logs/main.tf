resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.application_name}-${var.environment}"
  tags = var.tags
}
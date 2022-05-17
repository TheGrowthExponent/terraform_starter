resource "aws_cloudwatch_log_group" "example" {
  name = "${var.application_name}-${var.environment}"
  tags = var.tags
}
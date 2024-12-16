resource "aws_prometheus_workspace" "obs_platform" {
  alias = "${var.application_name}-${var.environment}"
  logging_configuration {
    log_group_arn = "${var.obs_platform_log_group_arn}:*"
  }
}

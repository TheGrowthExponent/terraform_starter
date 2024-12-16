
resource "aws_cloudwatch_event_rule" "lambda_event_rule" {
  name                = var.scheduler_name
  schedule_expression = var.rate
  event_pattern = jsonencode({
    "source" : ["aws.event_rule"]
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  arn  = var.lambda_function_arn
  rule = aws_cloudwatch_event_rule.lambda_event_rule.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_event_rule.arn
}

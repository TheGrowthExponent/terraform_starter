#resource "aws_lambda_layer_version" "snowflake_layer_v4" {
#  filename   = "${path.module}/Snowflake_Layer.zip"
#  layer_name = "Snowflake_Layer"
#
#  compatible_runtimes = ["python3.12"]
#}

#resource "aws_lambda_layer_version" "postgres_layer_v4" {
#  filename   = "${path.module}/Postgres_Layer.zip"
#  layer_name = "Postgres_Layer"
#
#  compatible_runtimes = ["python3.12"]
#}

# resource "aws_lambda_layer_version" "pyarrow_layer_v4" {
#   filename   = "${path.module}/Pyarrow_Layer.zip"
#   layer_name = "Pyarrow_Layer"

#   compatible_runtimes = ["python3.12"]
# }

resource "random_uuid" "lambda_src_hash" {
  keepers = {
    for filename in setunion(
      fileset(local.lambda_src_path, "/**/*")
    ) :
    filename => filemd5("${local.lambda_src_path}/${filename}")
  }
}

resource "aws_lambda_function" "lambda_function" {
  filename      = data.archive_file.lambda_source_package.output_path
  function_name = var.function_name
  role          = var.lambda_role_arn
  handler       = "handler.lambda_handler"
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout
  #  reserved_concurrent_executions = "5"
  tracing_config {
    mode = "Active"
  }
  layers = [
    "arn:aws:lambda:us-east-1:580247275435:layer:LambdaInsightsExtension:14",
    #    aws_lambda_layer_version.snowflake_layer_v4.arn,
    #    aws_lambda_layer_version.postgres_layer_v4.arn
  ]
  runtime          = "python3.12"
  source_code_hash = data.archive_file.lambda_source_package.output_base64sha256
  ephemeral_storage {
    size = 1024 # Min 512 MB and the Max 10240 MB
  }
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.load_balancer_sg_id]
  }
  environment {
    variables = var.env_vars
  }

  lifecycle {
    # Terraform will any ignore changes to the
    # environment variables after the first deploy.
    ignore_changes = [environment]
    replace_triggered_by = [
      data.archive_file.lambda_source_package.output_base64sha256
    ]
  }
}

resource "aws_lambda_event_source_mapping" "lambda_queue_event" {
  event_source_arn = var.queue_arn
  function_name    = aws_lambda_function.lambda_function.arn
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket_arn
}

# resource "aws_lambda_permission" "allow_event_rule_cron_12" {
#  statement_id  = "AllowExecutionFromCloudWatch"
#  action        = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.lambda_function.function_name
#  principal     = "events.amazonaws.com"
#  source_arn    = aws_cloudwatch_event_rule.cron_12_hour.arn
# }

resource "aws_lambda_alias" "lambda_function_alias" {
  name             = "${var.function_name}_alias"
  description      = "Latest version of Lambda"
  function_name    = aws_lambda_function.lambda_function.function_name
  function_version = "$LATEST"
}

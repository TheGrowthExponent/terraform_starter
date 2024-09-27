#resource "aws_lambda_layer_version" "snowflake_layer_v4" {
#  filename   = "${path.module}/Snowflake_Layer.zip"
#  layer_name = "Snowflake_Layer"
#
#  compatible_runtimes = ["python3.8"]
#}

#resource "aws_lambda_layer_version" "postgres_layer_v4" {
#  filename   = "${path.module}/Postgres_Layer.zip"
#  layer_name = "Postgres_Layer"
#
#  compatible_runtimes = ["python3.8"]
#}

# resource "aws_lambda_layer_version" "pyarrow_layer_v4" {
#   filename   = "${path.module}/Pyarrow_Layer.zip"
#   layer_name = "Pyarrow_Layer"

#   compatible_runtimes = ["python3.8"]
# }

resource "random_uuid" "lambda1_src_hash" {
  keepers = {
    for filename in setunion(
      fileset(local.lambda_src_path, "/lambda1/**/*")
    ) :
    filename => filemd5("${local.lambda_src_path}/lambda1/${filename}")
  }
}

resource "random_uuid" "lambda2_src_hash" {
  keepers = {
    for filename in setunion(
      fileset(local.lambda_src_path, "/lambda2/**/*")
    ) :
    filename => filemd5("${local.lambda_src_path}/lambda2/${filename}")
  }
}

resource "null_resource" "lambda1_dependencies" {
  provisioner "local-exec" {
    command = "pip install -r ${local.lambda_src_path}/lambda1/requirements.txt -t ${local.lambda_src_path}/lambda1 --upgrade"
  }

  # Only re-run this if the dependencies or their versions
  # have changed since the last deployment with Terraform
  triggers = {
    dependencies_versions = filemd5("${local.lambda_src_path}/lambda1/requirements.txt")
    #      source_code_hash      = random_uuid.lambda_src_hash.result # This is a suitable option too
  }
}

resource "null_resource" "lambda2_dependencies" {
  provisioner "local-exec" {
    command = "pip install -r ${local.lambda_src_path}/lambda2/requirements.txt -t ${local.lambda_src_path}/lambda2 --upgrade"
  }

  # Only re-run this if the dependencies or their versions
  # have changed since the last deployment with Terraform
  triggers = {
    dependencies_versions = filemd5("${local.lambda_src_path}/lambda2/requirements.txt")
    #      source_code_hash      = random_uuid.lambda_src_hash.result # This is a suitable option too
  }
}

resource "aws_lambda_function" "lambda1_function" {
  filename      = data.archive_file.lambda1_source_package.output_path
  function_name = "${var.application_name}_${var.environment}_lambda1"
  role          = var.lambda_role.arn
  handler       = "add_to_queue.lambda_handler"
  memory_size   = "512"
  timeout       = "30"
  #  reserved_concurrent_executions = "5"
  tracing_config {
    mode = "Active"
  }
  layers = [
    "arn:aws:lambda:ap-southeast-2:580247275435:layer:LambdaInsightsExtension:14",
    #    aws_lambda_layer_version.snowflake_layer_v4.arn,
    #    aws_lambda_layer_version.postgres_layer_v4.arn
  ]
  runtime          = "python3.8"
  source_code_hash = data.archive_file.lambda1_source_package.output_base64sha256
  ephemeral_storage {
    size = 1024 # Min 512 MB and the Max 10240 MB
  }
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.load_balancer_sg.id]
  }
  environment {
    variables = {
      ENV         = var.environment
      LOG_LEVEL   = var.lambda_log_level
      SECRET_NAME = var.secret_name
      QUEUE_NAME  = var.queue.name
      BUCKET_NAME = var.bucket.name
    }
  }

  lifecycle {
    # Terraform will any ignore changes to the
    # environment variables after the first deploy.
    ignore_changes = [environment]
  }
}

resource "aws_lambda_function" "lambda2_function" {
  filename      = data.archive_file.lambda2_source_package.output_path
  function_name = "${var.application_name}_${var.environment}_lambda2"
  role          = var.lambda_role.arn
  handler       = "upload_to_s3.lambda_handler"
  memory_size   = "512"
  timeout       = "30"
  #  reserved_concurrent_executions = "5"
  tracing_config {
    mode = "Active"
  }
  layers = [
    "arn:aws:lambda:ap-southeast-2:580247275435:layer:LambdaInsightsExtension:14",
    #        aws_lambda_layer_version.snowflake_layer_v4.arn,
    #    aws_lambda_layer_version.postgres_layer_v4.arn
  ]
  runtime          = "python3.8"
  source_code_hash = data.archive_file.lambda2_source_package.output_base64sha256
  ephemeral_storage {
    size = 10240 # Min 512 MB and the Max 10240 MB
  }
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.load_balancer_sg.id]
  }
  environment {
    variables = {
      ENV         = var.environment
      LOG_LEVEL   = var.lambda_log_level
      SECRET_NAME = var.secret_name
      QUEUE_NAME  = var.queue.name
      BUCKET_NAME = var.bucket.name
    }
  }

  lifecycle {
    # Terraform will any ignore changes to the
    # environment variables after the first deploy.
    ignore_changes = [environment]
  }
}

resource "aws_lambda_event_source_mapping" "lambda_queue_event" {
  event_source_arn = var.queue.arn
  function_name    = aws_lambda_function.lambda2_function.arn
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda1_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket.arn
}

#resource "aws_lambda_permission" "allow_event_rule_cron_12" {
#  statement_id  = "AllowExecutionFromCloudWatch"
#  action        = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.lambda1_function.function_name
#  principal     = "events.amazonaws.com"
#  source_arn    = aws_cloudwatch_event_rule.cron_12_hour.arn
#}

resource "aws_lambda_alias" "lambda1_function_alias" {
  name             = "${var.application_name}_${var.environment}_lambda1_alias"
  description      = "Latest version of Lambda1"
  function_name    = aws_lambda_function.lambda1_function.function_name
  function_version = "$LATEST"
}

resource "aws_lambda_alias" "lambda2_function_alias" {
  name             = "${var.application_name}_${var.environment}_lambda2_alias"
  description      = "Latest version of Lambda2"
  function_name    = aws_lambda_function.lambda2_function.function_name
  function_version = "$LATEST"
}

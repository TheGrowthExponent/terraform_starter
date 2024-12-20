resource "aws_iam_role" "batch_service" {
  name               = "app-role-batch-service-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.batch.json
  tags               = { purpose = "Project batch role" }
}

resource "aws_iam_role" "ec2_service" {
  name               = "app-role-ec2-service-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2.json
  tags               = { purpose = "Project ec2 role" }
}

resource "aws_iam_role" "ecs_service" {
  name               = "app-role-ecs-service-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs.json
  tags               = { purpose = "Project ecs role" }
}

resource "aws_iam_role" "grafana_service" {
  name               = "app-role-grafana-service-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.grafana.json
  tags               = { purpose = "Project grafana role" }
}

resource "aws_iam_role" "lambda_service" {
  name               = "app-role-lambda-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
  tags               = { purpose = "Project lambda role" }
}

resource "aws_iam_role" "sfn_service" {
  name               = "app-role-sfn-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sfn.json
  tags               = { purpose = "Project sfn role" }
}

resource "aws_iam_role" "apigw_service" {
  name               = "app-role-apigw-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.apigw.json
  tags               = { purpose = "Project apigw role" }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_service.name
}

resource "aws_iam_policy" "ecs_service_alb" {
  name        = "app-policy-ecs_service_alb-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow access to the service alb"
  policy      = data.aws_iam_policy_document.ecs_service_alb.json
}

resource "aws_iam_policy" "ecs_service_standard" {
  name        = "app-policy-ecs_service_standard-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow standard ecs actions"
  policy      = data.aws_iam_policy_document.ecs_service_standard.json
}

resource "aws_iam_policy" "ecs_service_scaling" {
  name        = "app-policy-ecs_service_scaling-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow ecs service scaling"
  policy      = data.aws_iam_policy_document.ecs_service_scaling.json
}

resource "aws_iam_policy" "allow_ecr" {
  name        = "app-policy-allow_ecr-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow ecs service scaling"
  policy      = data.aws_iam_policy_document.allow_ecr.json
}

resource "aws_iam_policy" "allow_secrets" {
  name        = "app-policy-allow_secrets-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow reading secrets"
  policy      = data.aws_iam_policy_document.allow_secrets.json
}

resource "aws_iam_policy" "disallow_unauthenticated_urls" {
  name        = "policy-disallow_unauthenticated_urls-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Disallow Unauthenticated Function Urls"
  policy      = data.aws_iam_policy_document.disallow_unauthenticated_urls.json
}

resource "aws_iam_policy" "allow_s3" {
  name        = "app-policy-allow_s3-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow access to project s3 bucket"
  policy      = data.aws_iam_policy_document.allow_s3.json
}

resource "aws_iam_policy" "allow_ses" {
  name        = "app-policy-allow_ses-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow sending emails using ses"
  policy      = data.aws_iam_policy_document.allow_ses.json
}

resource "aws_iam_policy" "allow_logging" {
  name        = "app-policy-allow_logging-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow logging"
  policy      = data.aws_iam_policy_document.allow_logging.json
}

resource "aws_iam_policy" "allow_ec2" {
  name        = "policy-allow_ec2-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow ec2"
  policy      = data.aws_iam_policy_document.allow_ec2.json
}

#resource "aws_iam_policy" "allow_dynamodb" {
#  name        = "policy-allow_dynamodb-${var.application_name}-${var.environment}"
#  path        = "/"
#  description = "Allow DynamoDBExecutions"
#  policy      = data.aws_iam_policy_document.allow_dynamodb.json
#}

resource "aws_iam_policy" "allow_sqs" {
  name        = "policy-allow_sqs-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow sqs"
  policy      = data.aws_iam_policy_document.allow_sqs.json
}

resource "aws_iam_policy" "invoke_lambda" {
  name        = "policy-invoke_lambda-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow invoke lambda"
  policy      = data.aws_iam_policy_document.invoke_lambda.json
}

resource "aws_iam_role_policy_attachment" "ec2_allow_secrets" {
  role       = aws_iam_role.ec2_service.name
  policy_arn = aws_iam_policy.allow_secrets.arn
}

resource "aws_iam_role_policy_attachment" "ec2_allow_logging" {
  role       = aws_iam_role.ec2_service.name
  policy_arn = aws_iam_policy.allow_logging.arn
}

resource "aws_iam_role_policy_attachment" "ec2_allow_s3" {
  role       = aws_iam_role.ec2_service.name
  policy_arn = aws_iam_policy.allow_s3.arn
}

resource "aws_iam_role_policy_attachment" "ecs_service_alb" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.ecs_service_alb.arn
}

resource "aws_iam_role_policy_attachment" "ecs_service_standard" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.ecs_service_standard.arn
}

resource "aws_iam_role_policy_attachment" "ecs_service_scaling" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.ecs_service_scaling.arn
}

resource "aws_iam_role_policy_attachment" "ecs_allow_ecr" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.allow_ecr.arn
}

resource "aws_iam_role_policy_attachment" "ecs_allow_secrets" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.allow_secrets.arn
}

resource "aws_iam_role_policy_attachment" "ecs_allow_s3" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.allow_s3.arn
}

resource "aws_iam_role_policy_attachment" "batch_service_managed_policy" {
  role       = aws_iam_role.batch_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_managed_policy" {
  role       = aws_iam_role.ec2_service.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_managed_policy" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_managed_policy" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_managed_policy" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_managed_policy" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_insights_managed_policy" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "lambda_allow_secrets" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.allow_secrets.arn
}

resource "aws_iam_role_policy_attachment" "lambda_disallow_unauthenticated_urls" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.disallow_unauthenticated_urls.arn
}

resource "aws_iam_role_policy_attachment" "lambda_allow_s3" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.allow_s3.arn
}

resource "aws_iam_role_policy_attachment" "lambda_allow_ses" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.allow_ses.arn
}

resource "aws_iam_role_policy_attachment" "lambda_allow_ec2" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.allow_ec2.arn
}

#resource "aws_iam_role_policy_attachment" "lambda_allow_dynamodb" {
#  role       = aws_iam_role.lambda_service.name
#  policy_arn = aws_iam_policy.allow_dynamodb.arn
#}

resource "aws_iam_role_policy_attachment" "lambda_allow_sqs" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.allow_sqs.arn
}

resource "aws_iam_role_policy_attachment" "sfn_allow_lambda" {
  role       = aws_iam_role.sfn_service.name
  policy_arn = aws_iam_policy.invoke_lambda.arn
}

resource "aws_iam_role_policy_attachment" "sfn_allow_logging" {
  role       = aws_iam_role.sfn_service.name
  policy_arn = aws_iam_policy.allow_logging.arn
}

resource "aws_iam_role_policy_attachment" "apigw_cloudwatch_managed_policy" {
  role       = aws_iam_role.apigw_service.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "apigw_allow_sqs" {
  role       = aws_iam_role.apigw_service.name
  policy_arn = aws_iam_policy.allow_sqs.arn
}

resource "aws_iam_role_policy_attachment" "apigw_allow_lambda" {
  role       = aws_iam_role.apigw_service.name
  policy_arn = aws_iam_policy.invoke_lambda.arn
}

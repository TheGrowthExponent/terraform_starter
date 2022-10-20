resource "aws_iam_role" "ecs_service" {
  name               = "role-ecs-service-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs.json
  tags               = { purpose = "Project ecs role" }
}

resource "aws_iam_role" "lambda_service" {
  name               = "role-lambda-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
  tags               = { purpose = "Project lambda role" }
}

resource "aws_iam_policy" "ecs_service_elb" {
  name        = "policy-ecs_service_elb-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow access to the service elb"
  policy      = data.aws_iam_policy_document.ecs_service_elb.json
}

resource "aws_iam_policy" "ecs_service_standard" {
  name        = "policy-ecs_service_standard-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow standard ecs actions"
  policy      = data.aws_iam_policy_document.ecs_service_standard.json
}

resource "aws_iam_policy" "ecs_service_scaling" {
  name        = "policy-ecs_service_scaling-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow ecs service scaling"
  policy      = data.aws_iam_policy_document.ecs_service_scaling.json
}

resource "aws_iam_policy" "allow_ecr" {
  name        = "policy-allow_ecr-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow ecs service scaling"
  policy      = data.aws_iam_policy_document.allow_ecr.json
}

resource "aws_iam_policy" "allow_secrets" {
  name        = "policy-allow_secrets-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow reading secrets"
  policy      = data.aws_iam_policy_document.allow_secrets.json
}

resource "aws_iam_policy" "allow_s3" {
  name        = "policy-allow_s3-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow s3"
  policy      = data.aws_iam_policy_document.allow_s3.json
}

resource "aws_iam_policy" "disallow_unauthenticated_urls" {
  name        = "policy-disallow_unauthenticated_urls-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Disallow Unauthenticated Function Urls"
  policy      = data.aws_iam_policy_document.disallow_unauthenticated_urls.json
}

resource "aws_iam_policy" "allow_logging" {
  name        = "policy-allow_logging-${var.application_name}-${var.environment}"
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

resource "aws_iam_role_policy_attachment" "ecs_service_elb" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.ecs_service_elb.arn
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

resource "aws_iam_role_policy_attachment" "lambda_allow_ec2" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.allow_ec2.arn
}


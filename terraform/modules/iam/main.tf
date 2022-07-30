resource "aws_iam_role" "ecs_service" {
  name = "${var.application_name}-${var.environment}-ecs-service"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.application_name}-${var.environment}-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}

resource "aws_iam_policy" "ecs_service_elb" {
  name        = "${var.application_name}-${var.environment}-ecs_service_elb"
  path        = "/"
  description = "Allow access to the service elb"
  policy      = data.aws_iam_policy_document.ecs_service_elb.json
}

resource "aws_iam_policy" "ecs_service_standard" {
  name        = "${var.application_name}-${var.environment}-ecs_service_standard"
  path        = "/"
  description = "Allow standard ecs actions"
  policy      = data.aws_iam_policy_document.ecs_service_standard.json
}

resource "aws_iam_policy" "ecs_service_scaling" {
  name        = "${var.application_name}-${var.environment}-ecs_service_scaling"
  path        = "/"
  description = "Allow ecs service scaling"
  policy      = data.aws_iam_policy_document.ecs_service_scaling.json
}

resource "aws_iam_policy" "allow_ecr" {
  name        = "${var.application_name}-${var.environment}-allow_ecr"
  path        = "/"
  description = "Allow ecs service scaling"
  policy      = data.aws_iam_policy_document.allow_ecr.json
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.application_name}-${var.environment}-lambda_policy"
  path        = "/"
  description = "Allow lambda access to resources"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_policy" "allow_s3" {
  name        = "${var.application_name}-${var.environment}-allow_s3"
  path        = "/"
  description = "Allow lambda access to resources"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_policy" "allow_sqs" {
  name        = "${var.application_name}-${var.environment}-allow_sqs"
  path        = "/"
  description = "Allow lambda access to resources"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_policy" "allow_sns" {
  name        = "${var.application_name}-${var.environment}-allow_sns"
  path        = "/"
  description = "Allow lambda access to resources"
  policy      = data.aws_iam_policy_document.lambda_policy.json
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

resource "aws_iam_role_policy_attachment" "ecs_service_scaling_allow_sns" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.allow_sns.arn
}

resource "aws_iam_role_policy_attachment" "allow_ecr" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.allow_ecr.arn
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_allow_s3" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.allow_s3.arn
}

resource "aws_iam_role_policy_attachment" "lambda_allow_sqs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.allow_sqs.arn
}

resource "aws_iam_role_policy_attachment" "lambda_allow_sns" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.allow_sns.arn
}

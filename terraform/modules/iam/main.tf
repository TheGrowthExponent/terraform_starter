resource "aws_iam_role" "ecs_service" {
  name               = "role-ecs-service-${var.application_name}-${var.environment}"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = [
            "ecs-tasks.amazonaws.com", "ecs.amazonaws.com"
          ]
        }
      },
    ]
  })
  tags = var.tags
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

resource "aws_iam_role_policy_attachment" "allow_ecr" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = aws_iam_policy.allow_ecr.arn
}

resource "aws_iam_role_policy_attachment" "ecs_managed_policy" {
  role       = aws_iam_role.ecs_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "lambda_service" {
  name               = "role-lambda-${var.application_name}-${var.environment}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
  tags               = merge(var.tags, { purpose = "Project lambda role" })
}

resource "aws_iam_policy" "allow_s3" {
  name        = "policy-allow_s3-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow s3"
  policy      = data.aws_iam_policy_document.allow_s3.json
}

resource "aws_iam_policy" "allow_logging" {
  name        = "policy-allow_logging-${var.application_name}-${var.environment}"
  path        = "/"
  description = "Allow logging"
  policy      = data.aws_iam_policy_document.allow_s3.json
}

resource "aws_iam_role_policy_attachment" "allow_s3" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.allow_s3.arn
}

resource "aws_iam_role_policy_attachment" "allow_logging" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.allow_logging.arn
}
resource "aws_iam_role" "ecs_service" {
  name               = "${var.application_name}-${var.environment}-ecs-service"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
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
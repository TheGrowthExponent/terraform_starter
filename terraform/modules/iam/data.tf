data "aws_iam_policy_document" "ecs_service_elb" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:Describe*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets"
    ]
    resources = [
      var.elb.arn
    ]
  }
}

data "aws_iam_policy_document" "ecs_service_standard" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeTags",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:UpdateContainerInstancesState",
      "ecs:Submit*",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "ecs_service_scaling" {
  statement {
    effect = "Allow"
    actions = [
      "application-autoscaling:*",
      "ecs:DescribeServices",
      "ecs:UpdateService",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DisableAlarmActions",
      "cloudwatch:EnableAlarmActions",
      "iam:CreateServiceLinkedRole",
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "allow_ecr" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    effect = "Allow"
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "s3:ListAllMyBuckets",
      "cloudwatch:Get*",
      "secretsmanager:GetSecretValue",
      "lambda:Get*",resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.application_name}-${var.environment}-lambda_policy"
  path        = "/"
  description = "Allow lambda access to resources"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

      "lambda:InvokeFunction",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "allow_s3" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetBucketTagging",
      "s3:GetObjectVersionTagging",
      "s3:ListBucketVersions",
      "s3:PutObjectVersionTagging",
      "s3:GetObjectTagging",
      "s3:ListBucket",
      "s3:PutObjectTagging",
      "s3:GetBucketVersioning",
      "s3:GetObjectVersion"
    ]
    resources = [var.bucket.arn, "${var.bucket.arn}/**/*"]
  }
}

data "aws_iam_policy_document" "allow_sqs" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:*",
    ]
    resources = var.queue.arn
  }
}

data "aws_iam_policy_document" "allow_sns" {
  statement {
    effect = "Allow"
    actions = [
      "sns:Subscribe",
      "sns:SetTopicAttributes",
      "sns:Receive",
      "sns:Publish",
      "sns:ListSubscriptionsByTopic",
      "sns:GetTopicAttributes"
    ]
    resources = [var.notifications_topic.arn, "${var.notifications_topic.arn}/**/*", var.error_notifications_topic.arn, "${var.error_notifications_topic.arn}/**/*"]
  }
}

data "aws_iam_policy_document" "lambda" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "allow_s3" {
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List",
    ]
    resources = [
      var.s3_bucket.arn,
      "${var.s3_bucket.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "allow_logging" {
  statement {
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
    ]
    resources = [
      "arn:aws:logs:ap-southeast-2:*:log-group::log-stream:*",
    ]
  }
    statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DeleteLogGroup",
                "logs:DeleteLogStream",
                "logs:DescribeLogStreams",
                "logs:FilterLogEvents",
                "logs:PutLogEvents"
    ]
    resources = [
      "${var.log_group.arn}:log-stream:*",
    ]
  }
}

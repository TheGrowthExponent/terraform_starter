data "aws_iam_policy_document" "batch" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ec2" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
        "ecs.amazonaws.com",
        "batchoperations.s3.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "disallow_unauthenticated_urls" {
  statement {
    effect = "Deny"
    actions = [
      "lambda:InvokeFunctionUrl",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      values   = ["NONE"]
      variable = "lambda:FunctionUrlAuthType"
    }
  }
}

data "aws_iam_policy_document" "lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "sfn" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "apigw" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_service_alb" {
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
      var.load_balancer.arn
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
      "ecs:ListClusters",
      "ecs:DeleteCluster",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = [
      "arn:aws:kms:*:${var.account_id}:key/*"
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
      "sns:CreateTopic",
      "sns:Subscribe",
      "sns:Get*",
      "sns:List*"
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
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "allow_secrets" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
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
      "s3:*"
    ]
    resources = [
      var.s3_bucket_arn,
      "${var.s3_bucket_arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "allow_ses" {
  statement {
    effect = "Allow"
    actions = [
      "ses:*"
    ]
    resources = [
      "*"
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
      "logs:DescribeLogGroups",
      "logs:FilterLogEvents",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
    ]
    resources = [
      "${var.log_group_arn}:*:*",
      "${var.log_group_arn}:log-stream:*",
    ]
  }
}

data "aws_iam_policy_document" "allow_ec2" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:AttachNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DetachNetworkInterface",
      "sqs:*"
    ]
    resources = ["*"]
  }
}

#data "aws_iam_policy_document" "allow_dynamodb" {
#  statement {
#    effect = "Allow"
#    actions = [
#      "dynamodb:*"
#    ]
#    resources = [
#      var.dynamodb.arn,
#      "${var.dynamodb.arn}/**/*",
#    ]
#  }
#}

data "aws_iam_policy_document" "allow_sqs" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:GetQueueUrl",
      "sqs:ChangeMessageVisibility",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:SendMessageBatch",
      "sqs:PurgeQueue",
      "sqs:ReceiveMessage",
      "sqs:SendMessage",
      "sqs:GetQueueAttributes",
      "sqs:CreateQueue",
      "sqs:ListQueueTags",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:SetQueueAttributes"
    ]
    resources = [
      var.sqs_queue_arn
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "sqs:GetQueueUrl",
      "sqs:ListQueues"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "invoke_lambda" {
  statement {
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = ["*"]
  }
}

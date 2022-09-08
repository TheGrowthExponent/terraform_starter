data "aws_iam_policy_document" "sqs_queue_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SQS:SendMessage",
    ]
    #    condition {
    #      test     = "ArnEquals"
    #      variable = "AWS:SourceArn"
    #      values   = [aws_lambda_function.lambda_function.arn,]
    #    }
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_sqs_queue.queue.arn,]
    sid       = "__default_statement_ID"
  }
}
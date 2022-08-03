resource "aws_sqs_queue" "dead_letter" {
  name = "deadletter-queue-${var.application_name}-${var.environment}"
  tags = var.tags
}

resource "aws_sqs_queue" "queue" {
  name                      = "queue-${var.application_name}-${var.environment}"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter.arn
    maxReceiveCount     = 4
  })
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.dead_letter.arn]
  })
  tags = var.tags
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.queue.id
  policy      = data.aws_iam_policy_document.sqs_queue_policy.json
}
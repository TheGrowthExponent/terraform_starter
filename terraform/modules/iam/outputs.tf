output "ecs_role" {
  value = aws_iam_role.ecs_service
}

output "lambda_role" {
  value = aws_iam_role.lambda_service
}

output "batch_role" {
  value = aws_iam_role.batch_service
}

output "ec2_role" {
  value = aws_iam_role.ec2_service
}

output "ecs_role" {
  value = aws_iam_role.ecs_service
}

output "grafana_service" {
  value = aws_iam_role.grafana_service
}

output "lambda_role" {
  value = aws_iam_role.lambda_service
}

output "apigw_role" {
  value = aws_iam_role.apigw_service
}

output "ec2_instance_profile" {
  value = aws_iam_instance_profile.ec2_instance_profile
}

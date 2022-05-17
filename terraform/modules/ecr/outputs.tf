output "aws_ecr_repository" {
  description = "aws_ecr_repository"
  value       = aws_ecr_repository.repository.id
}

output "aws_ecr_repository_arn" {
  description = "aws_ecr_repository"
  value       = aws_ecr_repository.repository.arn
}

output "aws_ecr_repository_url" {
  description = "aws_ecr_repository_url"
  value       = aws_ecr_repository.repository.repository_url
}
output "aws_s3_bucket" {
  description = "aws_s3_bucket"
  value       = aws_s3_bucket.example.id
}

output "aws_s3_bucket_arn" {
  description = "aws_s3_bucket"
  value       = aws_s3_bucket.example.arn
}

output "aws_s3_bucket_domain_name" {
  description = "aws_s3_bucket"
  value       = aws_s3_bucket.example.bucket_domain_name
}
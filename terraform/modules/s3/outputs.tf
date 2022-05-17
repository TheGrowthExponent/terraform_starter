output "aws_s3_bucket" {
  description = "aws_s3_bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "aws_s3_bucket_arn" {
  description = "aws_s3_bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "aws_s3_bucket_domain_name" {
  description = "aws_s3_bucket"
  value       = aws_s3_bucket.s3_bucket.bucket_domain_name
}
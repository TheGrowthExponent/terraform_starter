resource "aws_s3_bucket" "example" {
  bucket = "${var.application_name}-${var.environment}"
  tags   = var.tags
}

resource "aws_s3_bucket_metric" "bucket_metric" {
  bucket = aws_s3_bucket.example.bucket
  name   = "${var.application_name}-${var.environment}-metric"
}
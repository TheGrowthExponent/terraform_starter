resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.application_name}-${var.environment}"
  tags   = var.tags
}

resource "aws_s3_bucket_metric" "bucket_metric" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  name   = "${var.application_name}-${var.environment}-metric"
}
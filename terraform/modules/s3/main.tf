resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_metric" "bucket_metric" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  name   = "${aws_s3_bucket.s3_bucket.id}-metric"
}

#resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
#  bucket = aws_s3_bucket.s3_bucket.id
#  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
#}

#data "aws_iam_policy_document" "allow_access_from_another_account" {
#  statement {
#    principals {
#      type        = "AWS"
#       identifiers = [
#        "arn:aws:iam::111:role/xxx",
#        "arn:aws:iam::111:role/aws-reserved/sso.amazonaws.com/us-east-1/xxx"
#      ]
#    }
#    actions = [
#      "s3:GetObject",
#      "s3:ListBucket",
#    ]
#    resources = [
#      aws_s3_bucket.s3_bucket.arn,
#      "${aws_s3_bucket.s3_bucket.arn}/*",
#    ]
#  }
#}

resource "aws_ecr_repository" "repository" {
  name                 = "${var.application_name}-${var.environment}"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  repository  = aws_ecr_repository.repository.name
  policy      = data.aws_iam_policy_document.allow_ecr.json
}
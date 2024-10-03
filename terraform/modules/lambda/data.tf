# Create an archive form the Lambda source code,
# filtering out unneeded files.
data "archive_file" "lambda_source_package" {
  type        = "zip"
  source_dir  = local.lambda_src_path
  output_path = "${path.module}/.tmp/${random_uuid.lambda_src_hash.result}_1.zip"

  excludes = [
    "__pycache__",
    "core/__pycache__",
    "tests"
  ]

  lifecycle {
    replace_triggered_by = [terraform_data.lambda_dependencies]
  }
}

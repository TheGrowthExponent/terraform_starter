# Create an archive form the Lambda source code,
# filtering out unneeded files.
data "archive_file" "lambda1_source_package" {
  type        = "zip"
  source_dir  = "${local.lambda_src_path}/lambda1"
  output_path = "${path.module}/.tmp/${random_uuid.lambda1_src_hash.result}_1.zip"

  excludes = [
    "__pycache__",
    "core/__pycache__",
    "tests"
  ]

  # This is necessary, since archive_file is now a
  # `data` source and not a `resource` anymore.
  # Use `depends_on` to wait for the "install dependencies"
  # task to be completed.
  depends_on = [null_resource.lambda1_dependencies]
}

data "archive_file" "lambda2_source_package" {
  type        = "zip"
  source_dir  = "${local.lambda_src_path}/lambda2"
  output_path = "${path.module}/.tmp/${random_uuid.lambda2_src_hash.result}_2.zip"

  excludes = [
    "__pycache__",
    "core/__pycache__",
    "tests"
  ]

  # This is necessary, since archive_file is now a
  # `data` source and not a `resource` anymore.
  # Use `depends_on` to wait for the "install dependencies"
  # task to be completed.
  depends_on = [null_resource.lambda2_dependencies]
}

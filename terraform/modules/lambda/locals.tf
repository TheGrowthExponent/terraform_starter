locals {
  # Relative paths change if this configuration is
  # included as a module from Terragrunt.
  lambda_src_path = "${path.module}/src"
}

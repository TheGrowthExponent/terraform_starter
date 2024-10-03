# These cannot be variables, but could be updated dynamically later using terragrunt
# https://github.com/gruntwork-io/terragrunt#keep-your-remote-state-configuration-dry
#terraform {
#  backend "s3" {
#    bucket = "terraform-state-storage-bucket"
#    region = "ap-southeast-2"
#    key = "terraform.tfstate"
#  }
#}

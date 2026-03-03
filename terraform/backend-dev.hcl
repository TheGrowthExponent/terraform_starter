bucket       = "tf-state-123456789-ap-southeast-2-prod"
key          = "terraform/my-website/dev/global.tfstate"
region       = "ap-southeast-2"
encrypt      = true
use_lockfile = true
// This file is used for dev environment Terraform state. Do not use for prod.

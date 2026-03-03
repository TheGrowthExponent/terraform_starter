bucket       = "tf-state-123456789-ap-southeast-2-prod"
key          = "terraform/my-app/shared/global.tfstate"
region       = "ap-southeast-2"
encrypt      = true
use_lockfile = true
// This file is used for prod environment Terraform state. Do not use for dev.

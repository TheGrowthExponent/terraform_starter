provider "aws" {
  region = local.region
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  region = var.region
  alias  = "notags"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Terraform"   = "true"
      "Project"     = "reportify"
      "Environment" = var.environment
    }
  }
}

provider "awscc" {
  region = var.region
}

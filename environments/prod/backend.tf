terraform {
  backend "s3" {
    bucket         = "reportify-terraform-state-prod"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-lock-prod"
  }
}

module "cognito" {
  source = "../../modules/cognito"

  environment = var.environment
  region      = var.region
  application_hostnames = [
    "https://${var.application_hostname}",
    "http://localhost:3000",
    "http://localhost:8080",
  ]
}

variable "environment" {
  description = "The name of environment."
  type        = string
  default     = "prod"
}

variable "region" {
  description = "The region of AWS."
  type        = string
  default     = "ap-northeast-1"
}

variable "application_hostname" {
  description = "The hostname of application server."
  type        = string
  default     = "reportify.abelab.dev"
}

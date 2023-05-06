variable "environment" {
  description = "The name of environment."
  type        = string
}

variable "region" {
  description = "The region of cognito."
  type        = string
}

variable "application_hostnames" {
  description = "The hostnames of application."
  type        = list(string)
}
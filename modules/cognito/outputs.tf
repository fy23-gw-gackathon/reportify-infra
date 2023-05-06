output "domain" {
  description = "The domain of cognito."
  value       = "https://${aws_cognito_user_pool_domain.main.domain}.auth.${var.region}.amazoncognito.com"
}

output "user_pool_id" {
  description = "The id of user pool."
  value       = aws_cognito_user_pool.main.id
}

output "client_id" {
  description = "The client id of cognito client."
  value       = aws_cognito_user_pool_client.main.id
}

output "client_secret" {
  description = "The client secret of cognito client."
  value       = aws_cognito_user_pool_client.main.client_secret
}

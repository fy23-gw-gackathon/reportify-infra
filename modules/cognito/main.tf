resource "aws_cognito_user_pool" "main" {
  name = "reportify-user-pool-${var.environment}"

  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]
  mfa_configuration        = "OPTIONAL"

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    required                 = true

    string_attribute_constraints {
      min_length = "0"
      max_length = "2048"
    }
  }

  software_token_mfa_configuration {
    enabled = true
  }

  admin_create_user_config {
    allow_admin_create_user_only = true

    invite_message_template {
      email_message = "{username} の仮パスワードは {####} です。"
      email_subject = "【Reportify事務局】管理者コンソールに招待されました"
      sms_message   = "{username} の仮パスワードは {####} です。"
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = false
    temporary_password_validity_days = 7
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = aws_cognito_user_pool.main.name
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_pool_client" "main" {
  name            = "reportify-cognito-client-${var.environment}"
  user_pool_id    = aws_cognito_user_pool.main.id
  generate_secret = true
  callback_urls = [
    for hostname in var.application_hostnames : "${hostname}/login/oauth2/code/cognito"
  ]
  logout_urls                          = [for hostname in var.application_hostnames : "${hostname}/login"]
  explicit_auth_flows                  = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  prevent_user_existence_errors        = "ENABLED"
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "aws.cognito.signin.user.admin"]
  supported_identity_providers         = ["COGNITO"]
}

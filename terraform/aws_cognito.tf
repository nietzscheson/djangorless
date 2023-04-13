resource "aws_cognito_user_pool" "default" {
  name                     = local.name
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  username_configuration {
    case_sensitive = false
  }

  admin_create_user_config {
    invite_message_template {
      email_subject = "Your super secret temporary password"
      email_message = "{username} your temp password is {####}"
      sms_message   = "{username} your temp password is {####}"
    }
  }
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "Verification code: {####}"
    email_subject        = "Cognito verification code"
  }
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length                   = 6
    # require_lowercase                = true
    # require_uppercase                = true
    # require_numbers                  = true
    # require_symbols                  = true
    temporary_password_validity_days = 7
  }
  device_configuration {
    device_only_remembered_on_user_prompt = true
    challenge_required_on_new_device      = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name                                 = local.name
  user_pool_id                         = aws_cognito_user_pool.default.id
  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["implicit"] # code
  allowed_oauth_scopes                 = ["email", "openid"]
  prevent_user_existence_errors        = "ENABLED"
  supported_identity_providers         = ["COGNITO"]
  # TODO: What if prod is on a custom domain?
  callback_urls = ["http://localhost:3000/login"]
  logout_urls   = ["http://localhost:3000/logout"]
}


resource "aws_cognito_user_pool_domain" "main" {
  domain       = local.name
  user_pool_id = aws_cognito_user_pool.default.id
}

resource "aws_cognito_user" "admin" {
  user_pool_id = aws_cognito_user_pool.default.id
  username     = "admin@example.com"
  password     = "p3s8Word_123"

  attributes = {
    email          = "admin@example.com"
    email_verified = true
  }
}

resource "aws_cognito_user" "staff" {
  user_pool_id = aws_cognito_user_pool.default.id
  username     = "staff@example.com"
  password     = "p3s8Word_123"

  attributes = {
    email          = "staff@example.com"
    email_verified = true
  }
}

resource "aws_cognito_user" "user" {
  user_pool_id = aws_cognito_user_pool.default.id
  username     = "user@example.com"
  password     = "example"

  attributes = {
    email          = "user@example.com"
    email_verified = true
  }
}

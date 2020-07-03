resource "aws_cognito_user_pool" "pool" {
  depends_on = [
    aws_ses_email_identity.cognito_mailer
  ]
  name = "${var.domain}-${random_string.identifier.result}"
  email_configuration {
    email_sending_account = "DEVELOPER"
    source_arn = aws_ses_email_identity.cognito_mailer.arn
  }
  auto_verified_attributes = ["email"]
  username_attributes = ["email"]
  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
    email_subject_by_link = "Verify your email address with ${var.domain}"
    email_message_by_link = "Click here to verify your account: {##Click Here##}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"

  user_pool_id = aws_cognito_user_pool.pool.id
  generate_secret = false
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = replace(lower(var.domain), "/[^a-z0-9]/", "-")
  user_pool_id    = aws_cognito_user_pool.pool.id
}

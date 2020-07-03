resource "aws_secretsmanager_secret" "client" {
  name = "${var.domain}-${random_string.identifier.result}-cognito-client"
}

locals {
  assembled_client = {
    client_id = aws_cognito_user_pool_client.client.id
    client_secret = aws_cognito_user_pool_client.client.client_secret
  }
}

resource "aws_secretsmanager_secret_version" "client" {
  secret_id     = aws_secretsmanager_secret.client.id
  secret_string = jsonencode(local.assembled_client)
}
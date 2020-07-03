output "secret_id" {
  value = aws_secretsmanager_secret.client.name
}
output "secret_id" {
  value = aws_secretsmanager_secret.client.name
}

output "secret_arn" {
  value = aws_secretsmanager_secret.client.arn
}
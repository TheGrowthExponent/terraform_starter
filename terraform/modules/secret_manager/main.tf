resource "aws_secretsmanager_secret" "secret" {
  name = var.secret_name
  description = var.secret_description
}

resource "random_password" "password" {
  length  = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret_version" "secret_password" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode({
    username = "user_email_address"
    password = random_password.password.result
  })
}

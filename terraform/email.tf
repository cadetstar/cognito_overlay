resource "aws_route53_zone" "cognito" {
  count = var.route53_zone_id == "" ? 1 : 0
  name = var.domain
}

resource "aws_ses_domain_identity" "cognito" {
  domain = var.domain
}

resource "aws_route53_record" "cognito_verification" {
  zone_id = var.route53_zone_id == "" ? aws_route53_zone.cognito[0].zone_id : var.route53_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.cognito.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.cognito.verification_token]
}

resource "aws_ses_domain_identity_verification" "cognito_verification" {
  domain = aws_ses_domain_identity.cognito.id

  depends_on = [aws_route53_record.cognito_verification]
}

resource "aws_ses_email_identity" "cognito_mailer" {
  depends_on = [aws_ses_domain_identity.cognito]
  email = "${var.mail-from}@${var.domain}"
}
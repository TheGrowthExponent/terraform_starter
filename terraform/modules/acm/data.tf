data "aws_route53_zone" "selected" {
  zone_id = var.hosted_zone_id
}

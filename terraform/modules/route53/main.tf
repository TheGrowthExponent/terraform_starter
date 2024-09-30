#resource "aws_route53_record" "record" {
#  zone_id = data.aws_route53_zone.selected.zone_id
#  name    = "${var.host_name}.${data.aws_route53_zone.selected.name}"
#  type    = "CNAME"
#  ttl     = "5"
#  weighted_routing_policy {
#    weight = 100
#  }
#  set_identifier = var.environment
#  records        = [var.cname_destination_url]
#}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.host_name}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = var.load_balancer.dns_name
    zone_id                = var.load_balancer.zone_id
    evaluate_target_health = true
  }
}


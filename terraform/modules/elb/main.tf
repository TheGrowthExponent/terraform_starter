resource "aws_lb" "elb" {
  name               = "lb-${var.application_name}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    var.load_balancer_sg.id
  ]
  subnets = var.private_subnets
  tags    = var.tags
}

resource "aws_lb_target_group" "ecs" {
  name        = "tg-${var.application_name}-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200,302"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
  tags = var.tags
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
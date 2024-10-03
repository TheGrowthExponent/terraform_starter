output "alb" {
  value = aws_lb.alb
}

output "ecs_target_group_arn" {
  value = aws_lb_target_group.ecs.arn
}

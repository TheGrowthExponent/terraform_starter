output "load_balancer_security_group_arn" {
  description = "load_balancer_security_group_arn"
  value       = aws_security_group.load_balancer.arn
}

output "ecs_task_security_group_arn" {
  description = "ecs_task_security_group_arn"
  value       = aws_security_group.ecs_task.arn
}
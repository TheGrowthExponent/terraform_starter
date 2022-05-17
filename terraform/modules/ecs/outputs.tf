output "aws_ecs_cluster" {
  description = "aws_ecs_cluster"
  value       = aws_ecs_cluster.cluster.id
}

output "aws_ecs_cluster_arn" {
  description = "aws_ecs_cluster_arn"
  value       = aws_ecs_cluster.cluster.arn
}

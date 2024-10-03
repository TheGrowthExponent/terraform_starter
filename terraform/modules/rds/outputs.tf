output "db_dns_name" {
  value       = aws_rds_cluster.db_cluster.endpoint
  description = "Fully qualified domain name of the postgresql database server"
}
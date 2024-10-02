output "db_dns_name" {
  value       = aws_rds_cluster_endpoint.db_endpoint.endpoint
  description = "Fully qualified domain name of the postgresql database server"
}
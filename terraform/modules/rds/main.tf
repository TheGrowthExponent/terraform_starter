resource "aws_db_subnet_group" "default" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
  tags       = var.tags
}


# resource "aws_db_instance" "db_server" {
#   db_name                      = var.db_name
#   identifier = var.db_name
#   allocated_storage = 10
# # max_allocated_storage            = var.max_allocated_storage
#   instance_class               = var.instance_class
#   engine                       = var.engine
#   username                     = var.db_admin_user
#   manage_master_user_password  = true
#   db_subnet_group_name         = aws_db_subnet_group.default.name
#   license_model                = "postgresql-license"
#   port                         = 5432
#   # multi_az                     = true
#   vpc_security_group_ids       = var.vpc_security_group_ids
#   skip_final_snapshot          = true
#   final_snapshot_identifier    = "${var.application_name}-${var.environment}"
#   performance_insights_enabled = true
#   tags                         = var.tags
# }



resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier           = var.db_name
  engine                       = var.engine
  engine_mode                  = var.engine_mode
  engine_version               = var.engine_version
  database_name                = var.db_name
  master_username              = var.db_admin_user
  manage_master_user_password  = true
  storage_encrypted            = true
  vpc_security_group_ids       = var.vpc_security_group_ids
  db_subnet_group_name         = aws_db_subnet_group.default.name
  skip_final_snapshot          = true
  final_snapshot_identifier    = var.db_name
  performance_insights_enabled = true
  backup_retention_period      = 5
  availability_zones           = ["ap-southeast-2a", "ap-southeast-2b"]
  tags                         = var.tags
  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "db_instance" {
  cluster_identifier = aws_rds_cluster.db_cluster.id
  identifier_prefix  = var.db_name
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.db_cluster.engine
  engine_version     = aws_rds_cluster.db_cluster.engine_version
}

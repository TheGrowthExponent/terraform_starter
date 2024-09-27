resource "aws_db_subnet_group" "default" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_db_instance" "db_server" {
  db_name                      = var.db_name
  allocated_storage            = 20
  instance_class               = "db.t3.small"
  engine                       = "postgres"
  username                     = var.db_admin_user
  manage_master_user_password  = true
  db_subnet_group_name         = aws_db_subnet_group.default.name
  license_model                = "postgresql-license"
  port                         = 5432
  multi_az                     = true
  vpc_security_group_ids       = var.vpc_security_group_ids
  skip_final_snapshot          = false
  performance_insights_enabled = true
  tags                         = var.tags
}
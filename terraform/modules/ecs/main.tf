resource "aws_ecs_cluster" "cluster" {
  name = "${var.application_name}-${var.environment}-cluster"
  configuration {
    execute_command_configuration {
      kms_key_id = var.aws_key.id
      logging    = "OVERRIDE"
      log_configuration {
        cloud_watch_encryption_enabled = false // true
        cloud_watch_log_group_name     = var.log_group.id
      }
    }
  }
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = var.tags
}

resource "aws_ecs_cluster_capacity_providers" "cluster_capacity_provider" {
  cluster_name = aws_ecs_cluster.cluster.name
  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]
  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
  }
}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "${var.application_name}-${var.environment}-capacity-provider"
  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.autoscaling_group.arn
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  launch_configuration = aws_launch_configuration.as_conf.id
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = var.aws_ami.id
  instance_type = "t2.micro"
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "${var.application_name}-${var.environment}"
  container_definitions = <<TASK_DEFINITION
  [
  {
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "cpu": 512,
    "environment": [
      {
        "name": "AUTHOR",
        "value": "Jason Pascoe"
      }
    ],
    "memory": 1024,
    "image": "dockersamples/static-site",
    "essential": true,
    "name": "site"
  }
]
TASK_DEFINITION
  network_mode          = "awsvpc"
  requires_compatibilities = [
  "FARGATE"]
  memory             = "1024"
  cpu                = "512"
  execution_role_arn = var.ecs_role.arn
  task_role_arn      = var.ecs_role.arn
  tags               = var.tags
}

resource "aws_ecs_service" "service" {
  name             = "${var.application_name}-${var.environment}-service"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task_definition.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  lifecycle {
    ignore_changes = [
    desired_count]
  }
  network_configuration {
    subnets = [
      var.ecs_subnet_a.id,
      var.ecs_subnet_b.id,
    var.ecs_subnet_c.id]
    security_groups = [
    var.ecs_sg.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.ecs_target_group.arn
    container_name   = "site"
    container_port   = 80
  }
}
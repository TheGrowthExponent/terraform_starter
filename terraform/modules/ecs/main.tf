resource "aws_ecs_cluster" "cluster" {
  name = "${var.application_name}-${var.environment}-cluster"
  configuration {
    execute_command_configuration {
      kms_key_id = var.aws_kms_key_arn
      logging    = "OVERRIDE"
      log_configuration {
        cloud_watch_encryption_enabled = false // true
        cloud_watch_log_group_name     = var.aws_cloudwatch_log_group
      }
    }
  }
  tags = var.tags
}

resource "aws_ecs_cluster_capacity_providers" "cluster_capacity_providers" {
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
    managed_termination_protection = "ENABLED"
    managed_scaling {
      maximum_scaling_step_size = var.maximum_scaling_step_size
      minimum_scaling_step_size = var.minimum_scaling_step_size
      status                    = "ENABLED"
      target_capacity           = var.target_capacity
    }
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  launch_configuration = "ToDo"
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

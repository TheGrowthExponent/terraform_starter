resource "aws_ecs_cluster" "cluster" {
  name = "cluster-${var.application_name}-${var.environment}"
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
  cluster_name       = aws_ecs_cluster.cluster.name
  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]
  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
  }
}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "capacity-provider-${var.application_name}-${var.environment}"
  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.autoscaling_group.arn
    managed_scaling {
      maximum_scaling_step_size = var.maximum_scaling_step_size
      minimum_scaling_step_size = var.minimum_scaling_step_size
      status                    = "ENABLED"
      target_capacity           = var.target_capacity
    }
  }
}

resource "aws_launch_configuration" "t3_micro" {
  name            = "t3_micro-${var.application_name}-${var.environment}"
  image_id        = var.aws_ami.id
  instance_type   = "t3.micro"
  key_name        = var.aws_key.id
  security_groups = [var.sg.id]
}

resource "aws_launch_configuration" "t3_small" {
  name            = "t3_small-${var.application_name}-${var.environment}"
  image_id        = var.aws_ami.id
  instance_type   = "t3.small"
  key_name        = var.aws_key.id
  security_groups = [var.sg.id]
}

resource "aws_launch_configuration" "t3_medium" {
  name            = "t3_medium-${var.application_name}-${var.environment}"
  image_id        = var.aws_ami.id
  instance_type   = "t3.medium"
  key_name        = var.aws_key.id
  security_groups = [var.sg.id]
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "asg-${var.application_name}-${var.environment}"
  vpc_zone_identifier       = var.private_subnets
  desired_capacity          = var.target_capacity
  launch_configuration      = aws_launch_configuration.t3_small.name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = 120
  health_check_type         = "ELB"
  force_delete              = true
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 10
    }
    triggers = ["tag"]
  }
  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_notification" "example_notifications" {
  group_names = [
    aws_autoscaling_group.autoscaling_group.name,
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = var.sns_notifications_topic.arn
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "td-${var.application_name}-${var.environment}"
  container_definitions = <<TASK_DEFINITION
  [
  {
    "memory" : 1024,
    "cpu" : 512,
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "environment": [
      {
        "name": "S3BUCKET",
        "value": "${var.s3_bucket.id}"
      }
    ],
    "image": "${var.aws_ecr_repository.repository_url}:${var.aws_ecr_repository_version}",
    "essential": true,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.log_group.id}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "${var.application_name}-${var.environment}"
        }
      },
    "name": "streamlit"
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
  name             = "service-${var.application_name}-${var.environment}"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task_definition.arn
  desired_count    = var.target_capacity
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  network_configuration {
    subnets = var.private_subnets
    security_groups = [
    var.sg.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.ecs_target_group.arn
    container_name   = "example"
    container_port   = 80
  }
}
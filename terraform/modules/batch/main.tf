resource "aws_batch_job_definition" "batch_job_definition" {
  name                  = var.batch_name
  type                  = "container"
  platform_capabilities = [var.compute_environment]
  container_properties = jsonencode({
    image      = "${var.aws_ecr_repository.repository_url}:${var.aws_ecr_repository_version}"
    jobRoleArn = var.ecs_task_execution_role.arn

    resourceRequirements = [
      {
        type  = "VCPU"
        value = tostring(var.vcpu)
      },
      {
        type  = "MEMORY"
        value = tostring(var.memory)
      }
    ]
    environment = [
      {
        name  = "S3_BUCKET"
        value = var.s3_bucket_name
      }
    ]
    executionRoleArn = var.ecs_task_execution_role.arn
    tags             = var.tags
  })
}

resource "aws_batch_compute_environment" "compute_environment_ec2" {
  count                    = var.compute_environment == "EC2" ? 1 : 0
  compute_environment_name = var.batch_name
  type                     = "MANAGED"
  compute_resources {
    allocation_strategy = "BEST_FIT_PROGRESSIVE"
    max_vcpus           = 4
    min_vcpus           = 0
    security_group_ids  = var.security_group_ids
    subnets             = var.subnet_ids
    type                = var.compute_environment
    instance_role       = var.ecs_instance_role.arn
    instance_type       = ["optimal"]
  }
  update_policy {
    job_execution_timeout_minutes = 30
    terminate_jobs_on_update      = false
  }
  service_role = var.batch_service_role.arn
  tags         = var.tags
}

resource "aws_batch_compute_environment" "compute_environment_fargate" {
  count                    = var.compute_environment == "FARGATE" ? 1 : 0
  compute_environment_name = var.batch_name
  type                     = "MANAGED"
  compute_resources {
    allocation_strategy = "BEST_FIT_PROGRESSIVE"
    max_vcpus           = 4
    min_vcpus           = 0
    security_group_ids  = var.security_group_ids
    subnets             = var.subnet_ids
    type                = var.compute_environment
  }
  update_policy {
    job_execution_timeout_minutes = 30
    terminate_jobs_on_update      = false
  }
  service_role = var.batch_service_role.arn
  tags         = var.tags
}

resource "aws_batch_job_queue" "job_queue_ec2" {
  count    = var.compute_environment == "EC2" ? 1 : 0
  name     = var.batch_name
  state    = "ENABLED"
  priority = 1
  compute_environment_order {
    compute_environment = aws_batch_compute_environment.compute_environment_ec2[0].arn
    order               = 1
  }
  tags = var.tags
}

resource "aws_batch_job_queue" "job_queue_fargate" {
  count    = var.compute_environment == "FARGATE" ? 1 : 0
  name     = var.batch_name
  state    = "ENABLED"
  priority = 1
  compute_environment_order {
    compute_environment = aws_batch_compute_environment.compute_environment_fargate[0].arn
    order               = 1
  }
  tags = var.tags
}

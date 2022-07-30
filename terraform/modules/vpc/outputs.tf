### If using your own VPC, add `data.` prefix when referencing existing resources specified in data.tf
output "vpc" {
  value = aws_vpc.vpc
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}

output "load_balancer_subnet_a" {
  value = aws_subnet.elb_a
}

output "load_balancer_subnet_b" {
  value = aws_subnet.elb_b
}

output "load_balancer_subnet_c" {
  value = aws_subnet.elb_c
}

output "ecs_subnet_a" {
  value = aws_subnet.ecs_a
}

output "ecs_subnet_b" {
  value = aws_subnet.ecs_b
}

output "ecs_subnet_c" {
  value = aws_subnet.ecs_c
}

output "load_balancer_sg" {
  value = aws_security_group.load_balancer
}

output "ecs_sg" {
  value = aws_security_group.ecs_task
}
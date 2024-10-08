output "vpc" {
  value = aws_vpc.vpc
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}

output "public_subnet_a" {
  value = aws_subnet.public_a
}

output "public_subnet_b" {
  value = aws_subnet.public_b
}

#output "public_subnet_c" {
#  value = data.aws_subnet.public_c
#}

output "private_subnet_a" {
  value = aws_subnet.private_a
}

output "private_subnet_b" {
  value = aws_subnet.private_b
}

#output "private_subnet_c" {
#  value = data.aws_subnet.private_c
#}

output "sg_batch" {
  value = aws_security_group.batch
}

output "sg_lb" {
  value = aws_security_group.load_balancer
}

output "sg_ec2" {
  value = aws_security_group.ec2
}

output "sg_ecs" {
  value = aws_security_group.ecs
}

output "sg_rds" {
  value = aws_security_group.rds
}

data "aws_availability_zones" "available" {}

### Uncomment below to use your existing VPC
### If using your own VPC, add `data.` prefix when referencing existing resources specified below

#data "aws_vpc" "vpc" {
#  id = var.vpc_id
#}
#
#data "aws_subnet" "elb_a" {
#  id = var.public_subnets[0]
#}
#
#data "aws_subnet" "elb_b" {
#  id = var.public_subnets[1]
#}
#
##data "aws_subnet" "elb_c" {
##  id = var.public_subnets[2]
##}
#
#data "aws_subnet" "ecs_a" {
#  id = var.private_subnets[0]
#}
#
#data "aws_subnet" "ecs_b" {
#  id = var.private_subnets[1]
#}
#
##data "aws_subnet" "ecs_c" {
##  id = var.private_subnets[2]
##}
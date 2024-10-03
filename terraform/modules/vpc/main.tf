### Remove the parts you dont need to create if using existing VPC
### If using your own VPC, add `data.` prefix when referencing existing resources specified in data.tf
resource "aws_vpc" "vpc" {
  cidr_block           = "192.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "internal_gateway" {
  vpc_id = aws_vpc.vpc.id
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.internal_gateway]
}

/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id
  depends_on    = [aws_internet_gateway.internal_gateway]
  tags = {
    Name = "nat"
  }
}

# resource "aws_route_table" "route_table" {
#   vpc_id = aws_vpc.vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.internal_gateway.id
#   }
# }

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "private-route-table"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internal_gateway.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# resource "aws_route" "public_internet_gateway" {
#   route_table_id         = aws_route_table.public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.internal_gateway.id
# }
#
# resource "aws_route" "private_nat_gateway" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat.id
# }

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.0.0.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_b"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_c"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.0.3.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "private_a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.0.4.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "private_b"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "192.0.5.0/24"
  availability_zone       = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "private_c"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "batch" {
  name   = "batch-sg-${var.application_name}-${var.environment}"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "load_balancer" {
  name   = "lb-sg-${var.application_name}-${var.environment}"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "ec2" {
  name   = "ec2-sg-${var.application_name}-${var.environment}"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "ecs" {
  name   = "ecs-sg-${var.application_name}-${var.environment}"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "rds" {
  name   = "rds-sg-${var.application_name}-${var.environment}"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "ingress_load_balancer_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.load_balancer.id
  to_port           = 80
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  type = "ingress"
}

resource "aws_security_group_rule" "ingress_load_balancer_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.load_balancer.id
  to_port           = 443
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  type = "ingress"
}

resource "aws_security_group_rule" "ingress_ecs_alb" {
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs.id
  to_port                  = 80
  source_security_group_id = aws_security_group.load_balancer.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "egress_batch" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.batch.id
}

resource "aws_security_group_rule" "egress_load_balancer" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.load_balancer.id
}

resource "aws_security_group_rule" "egress_ec2" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "egress_ecs" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.ecs.id
}

resource "aws_network_acl" "load_balancer" {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id,
    aws_subnet.public_c.id
  ]
}

resource "aws_network_acl" "ec2" {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
    aws_subnet.private_c.id
  ]
}

resource "aws_network_acl_rule" "load_balancer_http" {
  network_acl_id = aws_network_acl.load_balancer.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "load_balancer_https" {
  network_acl_id = aws_network_acl.load_balancer.id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "ingress_load_balancer_ephemeral" {
  network_acl_id = aws_network_acl.load_balancer.id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ec2_task_ephemeral" {
  network_acl_id = aws_network_acl.ec2.id
  rule_number    = 130
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ec2_task_http" {
  network_acl_id = aws_network_acl.ec2.id
  rule_number    = 140
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.vpc.cidr_block
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "load_balancer_ephemeral" {
  network_acl_id = aws_network_acl.load_balancer.id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 65535
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "ec2_task_all" {
  network_acl_id = aws_network_acl.ec2.id
  rule_number    = 210
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 65535
  cidr_block     = "0.0.0.0/0"
}

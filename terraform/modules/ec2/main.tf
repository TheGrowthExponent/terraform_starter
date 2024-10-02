################ EC2 ################
resource "aws_kms_key" "this" {
}

resource "aws_key_pair" "aws_key" {
  key_name   = "app-${var.application_name}-${var.environment}"
  public_key = var.public_key
}

resource "aws_instance" "example_server" {
  ami = var.ami
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.0031
    }
  }
  instance_type               = "t3.nano"
  iam_instance_profile        = var.ec2_instance_profile.id
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  key_name                    = aws_key_pair.aws_key.key_name
  monitoring                  = true
  vpc_security_group_ids      = [var.sg.id]
  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = var.volume_size
    volume_type           = "gp3"
    throughput            = 125
    delete_on_termination = false
  }
  user_data = <<EOF
#!/bin/bash
echo "Copying the SSH Key to the server"
echo -e "${var.public_key}" >> /home/ubuntu/.ssh/authorized_keys
EOF
  tags = {
    Name = var.instance_name
  }
}

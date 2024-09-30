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
  instance_type = "t3.nano"
  # iam_instance_profile = aws_iam_instance_profile.example_profile.name
  subnet_id       = var.private_subnet_id.id
  key_name        = aws_key_pair.aws_key.key_name
  monitoring      = true
  security_groups = [var.sg.id]
  user_data       = <<EOF
#!/bin/bash
echo "Copying the SSH Key to the server"
echo -e "${var.public_key}" >> /home/ubuntu/.ssh/authorized_keys
EOF
  tags = {
    Name = var.instance_name
  }
}

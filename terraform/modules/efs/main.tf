# EFS file system
resource "aws_efs_file_system" "shared_efs" {
  creation_token = var.efs_name
  lifecycle_policy {
    transition_to_ia =  var.transition_to_ia
  }
  tags =
    {
      Name = var.efs_name
    }
}

# EFS file system policy
resource "aws_efs_file_system_policy" "shared_efs" {
  file_system_id = aws_efs_file_system.shared_efs.id
  bypass_policy_lockout_safety_check = true
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AccessThroughMountTarget",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "elasticfilesystem:ClientRootAccess",
                "elasticfilesystem:ClientWrite",
                "elasticfilesystem:ClientMount"
            ],
            "Resource": "${aws_efs_mount_target.shared_fs[0].file_system_arn}",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                },
                "Bool": {
                    "elasticfilesystem:AccessedViaMountTarget": "true"
                }
            }
        },
        {
            "Sid": "EC2Access",
            "Effect": "Allow",
            "Principal": { "AWS": "${var.ec2_role_arn}" },
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                },
                "StringEquals": {
                    "elasticfilesystem:AccessPointArn" : "${aws_efs_access_point.ec2.arn}"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_efs_mount_target" "shared_fs" {
  count = length(var.private_subnets)
  file_system_id = aws_efs_file_system.shared_efs.id
  subnet_id      = var.private_subnets[count.index]
  security_groups = [ var.shared_efs_sg_id ]
}

# EFS access points
resource "aws_efs_access_point" "ec2" {
  file_system_id = aws_efs_file_system.shared_efs.id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/mnt/shared_efs"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 755
    }
  }
  tags =
    {
      Name = var.efs_name
    }
}
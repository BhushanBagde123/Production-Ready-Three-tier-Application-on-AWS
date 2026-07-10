resource "aws_launch_template" "app_lt" {

  name_prefix   = "application-"
  image_id      = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile {
    name = var.instance_profile_name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y

yum install docker -y

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

mkdir -p /opt/app
EOF
)

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "application"
    }
  }
}
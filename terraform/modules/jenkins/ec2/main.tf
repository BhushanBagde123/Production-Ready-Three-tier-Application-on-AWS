resource "aws_instance" "jenkins" {

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids       = [var.security_group_id]
  iam_instance_profile         = var.instance_profile_name
  associate_public_ip_address  = false

  user_data = base64encode(<<EOF
#!/bin/bash

yum update -y

# Java
yum install java-17-amazon-corretto -y

# Git
yum install git -y

# Docker
yum install docker -y
systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user
usermod -aG docker jenkins || true

# Jenkins Repository
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

yum install jenkins -y

systemctl enable jenkins
systemctl start jenkins

EOF
)

  tags = {
    Name = "jenkins"
  }
}
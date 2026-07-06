#!/bin/bash

aws ssm send-command \
--region ap-south-1 \
--document-name "AWS-RunShellScript" \
--targets "Key=tag:Name,Values=application" \
--comment "Deploy latest Docker images" \
--parameters 'commands=[
"mkdir -p /opt/app",
"cd /opt/app",
"aws s3 cp s3://appliaction-project-config/docker-compose.yml .",
"aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 412664885824.dkr.ecr.ap-south-1.amazonaws.com",
"docker compose pull",
"docker compose down",
"docker compose up -d"
]'
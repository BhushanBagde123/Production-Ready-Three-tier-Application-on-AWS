
# ─────────────────────────────
# VPC
# ─────────────────────────────

module "vpc" {
  source   = "../../modules/infrastructure"
aws_region = var.region
vpc_cidr = var.vpc_cidr
vpc_name = "prod-vpc"
public_subnet_1_cidr = var.public_subnet_1_cidr
public_subnet_2_cidr = var.public_subnet_2_cidr
private_subnet_1_cidr = var.private_subnet_1_cidr
private_subnet_2_cidr = var.private_subnet_2_cidr
private_subnet_3_cidr = var.private_subnet_3_cidr
private_subnet_4_cidr = var.private_subnet_4_cidr
availability_zone_1a = var.availability_zone-1a
availability_zone_1b = var.availability_zone-1b
vpc_id            = module.vpc.vpc_id
 allowed_ssh_cidr = ["0.0.0.0/0"]   
}

module "app_alb" {
source = "../../modules/loadbalancer"
aws_region = var.region
vpc_id = module.vpc.vpc_id
subnets = module.vpc.public_subnets
security_group_id = module.vpc.alb_app_sg_id
app_alb_name = "app-alb"
app_target_group_name = "app-tg"
}

module "jenkins_alb" {
source = "../../modules/loadbalancer"
aws_region = var.region
vpc_id = module.vpc.vpc_id
subnets = module.vpc.public_subnets
security_group_id = module.vpc.alb_jenkins_sg_id
jenkins_alb_name = "jenkins-alb"
jenkins_target_group_name = "jenkins-tg"
}


module "iam" {
  source = "../../modules/iam-role"
  
}

module "jenkins" {

  source = "../../modules/jenkins/ec2"

  ami                   = var.ami
  instance_type         =  var.instance_type

  private_web_subnets  = module.vpc.private_web_subnets

  security_group_id     = module.vpc.jenkins_sg_id

  instance_profile_name = module.iam.jenkins_instance_profile_name
}

module "ecr" {

  source = "../../modules/ecr"

  frontend_repo_name = "frontend-ecr-repo"

  backend_repo_name  = "backend-ecr-repo"

}


module "s3" {

  source = "../../modules/s3"

  bucket_name = "application-project-config"

}


# ─────────────────────────────
# RDS (DB Tier)
# ─────────────────────────────
module "rds" {
source         = "../../modules/database"
aws_region   = var.region
project_name = "three-tier"
identifier   = "form-rds"
allocated_storage = 20
engine            = "mysql"
engine_version    = "8.0"
instance_class    = var.instance_class
multi_az          = false
db_name           = "formDB"
db_username       = var.db_username
db_password       = var.db_password
db_subnet_1_id    = module.vpc.private_db_subnets[0]
db_subnet_2_id    = module.vpc.private_db_subnets[1]
rds_sg_id         = module.vpc.database_sg_id

}




module "launch_template" {
  source = "../../modules/lauch_template"

  ami                   = var.ami
  instance_type         = var.instance_type
  security_group_id     = module.vpc.app_sg_id
  instance_profile_name = module.iam.application_instance_profile_name
}

module "autoscaling" {
  source = "../../modules/auto-scaling"

  launch_template_id = module.launch_template.launch_template_id
  target_group_arn   = module.app_alb.app_target_group_arn
  private_subnet    = module.vpc.private_web_subnets
}
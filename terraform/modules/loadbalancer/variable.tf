variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = ""
}
variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "app_alb_name" {
  type    = string
  default = "app-alb"
}

variable "jenkins_alb_name" {
  type    = string
  default = "jenkins-alb"
}

variable "app_target_group_name" {
  type    = string
  default = "app-tg"
}

variable "jenkins_target_group_name" {
  type    = string
  default = "jenkins-tg"
}
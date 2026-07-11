variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "private_web_subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "instance_profile_name" {
  type = string
}
output "vpc_id" {
  value = aws_vpc.three_tier.id
}

output "public_subnets" {
  value = [aws_subnet.pub1.id, aws_subnet.pub2.id]
}

output "private_web_subnets" {
  value = [aws_subnet.prvt3.id, aws_subnet.prvt4.id]
}

output "private_app_subnets" {
  value = [aws_subnet.prvt5.id, aws_subnet.prvt6.id]
}

output "private_db_subnets" {
  value = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
}
output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}




output "alb_app_sg_id" {
  description = "ID of the Frontend ALB SG"
  value       = aws_security_group.alb_app.id
}



output "app_sg_id" {
  description = "ID of the Frontend Server SG"
  value       = aws_security_group.app_sg.id
}



output "database_sg_id" {
  description = "ID of the Database SG"
  value       = aws_security_group.database.id
}
output "jenkins_sg_id" {
  description = "ID of the Database SG"
  value       = aws_security_group.jenkins_sg.id
}
output "alb_jenkins_sg_id" {
  description = "ID of the Database SG"
  value       = aws_security_group.alb_jenkins.id
}

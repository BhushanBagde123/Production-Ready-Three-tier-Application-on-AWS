output "app_alb_dns" {
  value = aws_lb.app_alb.dns_name
}

output "app_alb_arn" {
  value = aws_lb.app_alb.arn
}

output "jenkins_alb_dns" {
  value = aws_lb.jenkins_alb.dns_name
}

output "jenkins_alb_arn" {
  value = aws_lb.jenkins_alb.arn
}

output "app_target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

output "jenkins_target_group_arn" {
  value = aws_lb_target_group.jenkins_tg.arn
}
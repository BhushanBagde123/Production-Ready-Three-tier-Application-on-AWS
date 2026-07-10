output "application_instance_profile_name" {
  value = aws_iam_instance_profile.application_profile.name
}

output "application_instance_profile_arn" {
  value = aws_iam_instance_profile.application_profile.arn
}

output "jenkins_instance_profile_name" {
  value = aws_iam_instance_profile.jenkins_profile.name
}

output "jenkins_instance_profile_arn" {
  value = aws_iam_instance_profile.jenkins_profile.arn
}
resource "aws_autoscaling_group" "app_asg" {

  desired_capacity = 2
  max_size         = 3
  min_size         = 2

  vpc_zone_identifier = var.private_subnet

  target_group_arns = [var.target_group_arn]

  launch_template {

    id      = var.launch_template_id

    version = "$Latest"

  }
}
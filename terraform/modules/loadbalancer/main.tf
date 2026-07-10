# app
resource "aws_lb_target_group" "app_tg" {
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb" "app_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.security_group_id]
  subnets         = var.subnets

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.app_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {

    type             = "forward"

    target_group_arn = aws_lb_target_group.app_tg.arn

  }
}
#Jenkins
resource "aws_lb_target_group" "jenkins_tg" {

  name        = var.target_group_name

  port        = 8080

  protocol    = "HTTP"

  vpc_id      = var.vpc_id

  target_type = "instance"

  health_check {

    path = "/login"

    matcher = "200"

    protocol = "HTTP"

  }

}

resource "aws_lb" "jenkins_alb" {

  name = var.alb_name

  internal = false

  load_balancer_type = "application"

  security_groups = [var.security_group_id]

  subnets = var.subnets

}

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.jenkins_alb.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.jenkins_tg.arn

  }

}
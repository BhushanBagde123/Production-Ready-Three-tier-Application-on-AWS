# ===========================
# App Target Group
# ===========================
resource "aws_lb_target_group" "app_tg" {
  name        = var.app_target_group_name
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
    Name = var.app_target_group_name
  }
}

# ===========================
# App ALB
# ===========================
resource "aws_lb" "app_alb" {
  name               = var.app_alb_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.security_group_id]
  subnets          = var.subnets

  tags = {
    Name = var.app_alb_name
  }
}

# ===========================
# App Listener
# ===========================
resource "aws_lb_listener" "app_http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# ===========================
# Jenkins Target Group
# ===========================
resource "aws_lb_target_group" "jenkins_tg" {
  name        = var.jenkins_target_group_name
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.jenkins_target_group_name
  }
}

# ===========================
# Jenkins ALB
# ===========================
resource "aws_lb" "jenkins_alb" {
  name               = var.jenkins_alb_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [var.security_group_id]
  subnets          = var.subnets

  tags = {
    Name = var.jenkins_alb_name
  }
}

# ===========================
# Jenkins Listener
# ===========================
resource "aws_lb_listener" "jenkins_http" {
  load_balancer_arn = aws_lb.jenkins_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
  }
}


# ALB App SG
resource "aws_security_group" "alb_app" {
  name        = "alb_app_sg"
  description = "Allow HTTP/HTTPS from public"
  vpc_id      = var.vpc_id

    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_app_sg"
  }
}

# ALB jenkins SG
resource "aws_security_group" "alb_jenkins" {
  name        = "alb_jenkins_sg"
  description = "Allow HTTP/HTTPS for backend"
  vpc_id      = var.vpc_id

    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_jenkins_sg"
  }
}

# App Server SG
resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = " HTTP for alb servers"
  vpc_id      = var.vpc_id

  
  # Frontend (Nginx)
  ingress {
    description     = "Frontend from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_app.id]
  }

  # Backend API
  ingress {
    description     = "Backend API from ALB"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_app.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app_sg"
  }
}
#jenkins-sg

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow ALB access"
  vpc_id      = var.vpc_id

  ingress {
    description = "ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_jenkins.id]
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database_sg"
  }
}



# Database SG
resource "aws_security_group" "database" {
  name        = "database_sg"
  description = "Allow MySQL access"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL/Aurora"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database_sg"
  }
}

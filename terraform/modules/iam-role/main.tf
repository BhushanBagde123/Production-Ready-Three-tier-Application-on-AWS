#application
resource "aws_iam_role" "application_role" {

  name = "application-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}
#attach manage policy

resource "aws_iam_role_policy_attachment" "ssm" {

  role       = aws_iam_role.application_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_role_policy_attachment" "ecr" {

  role       = aws_iam_role.application_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}

resource "aws_iam_role_policy_attachment" "s3" {

  role       = aws_iam_role.application_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

}

#jenkins role
resource "aws_iam_role" "jenkins_role" {

  name = "jenkins-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "jenkins_ecr" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"

}

resource "aws_iam_role_policy_attachment" "jenkins_s3" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}

resource "aws_iam_role_policy_attachment" "jenkins_ssm" {

  role = aws_iam_role.jenkins_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"

}
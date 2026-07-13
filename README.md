# 🚀 Production Ready Three Tier Application on AWS

Project Overview

This project demonstrates the deployment of a production-style three-tier web application on AWS using Infrastructure as Code (Terraform) and an automated CI/CD pipeline with Jenkins.

The infrastructure is designed following AWS best practices, including public and private subnets, Auto Scaling, Load Balancers, IAM Roles, and secure application deployment using Docker, Amazon ECR, Amazon S3, and AWS Systems Manager (SSM).

## 🌐 Architecture


![AWS Architecture](images/three-tier%20architecture1.png)


---
## ✨ Features

- ✅ Three Tier Architecture
- ✅ Terraform
- ✅ Docker
- ✅ Jenkins
- ✅ Auto Scaling
- ✅ Application Load Balancer
- ✅ Amazon ECR
- ✅ Amazon S3
- ✅ AWS Systems Manager


---
## 🛠️ Technologies

| Service | Usage |
|---------|-------|
| AWS | Cloud |
| Terraform | IaC |
| Docker | Containerization |
| Jenkins | CI/CD |

---
## ## ⚙️ CI/CD Workflow

The project uses **Jenkins** to automate the complete build and deployment process.

### CI (Continuous Integration)

1. The developer pushes code to the GitHub repository.
2. GitHub Webhook automatically triggers the Jenkins pipeline.
3. Jenkins checks out the latest source code from GitHub.
4. Jenkins builds Docker images for both the frontend and backend applications.
5. Jenkins logs in to Amazon ECR.
6. Docker images are tagged and pushed to their respective Amazon ECR repositories.

### CD (Continuous Deployment)

7. Jenkins uploads the latest `docker-compose.yml` and `.env` files to the Amazon S3 configuration bucket.
8. Jenkins uses AWS Systems Manager (SSM) to send deployment commands to the application EC2 instances running in the Auto Scaling Group.
9. Each EC2 instance downloads the latest deployment configuration from Amazon S3.
10. The instances authenticate with Amazon ECR and pull the latest Docker images.
11. Docker Compose starts or updates the application containers.
12. The Application Load Balancer routes user traffic only to healthy EC2 instances.

### 🚀 Deployment Flow

```text
Developer
     │
     ▼
Git Push
     │
     ▼
GitHub Repository
     │
     ▼
GitHub Webhook
     │
     ▼
Jenkins Pipeline
     │
     ▼
Build Docker Images
     │
     ▼
Push Images to Amazon ECR
     │
     ▼
Upload docker-compose.yml & .env to Amazon S3
     │
     ▼
AWS Systems Manager (SSM)
     │
     ▼
Auto Scaling EC2 Instances
     │
     ▼
Download Configuration from Amazon S3
     │
     ▼
Pull Docker Images from Amazon ECR
     │
     ▼
Docker Compose Deployment
     │
     ▼
Application Load Balancer
     │
     ▼
End Users
```
## 📁 Project Structure

```text
full-stack-project/
│
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   ├── server.js
│   └── ...
│
├── frontend/
│   ├── Dockerfile
│   ├── src/
│   ├── public/
│   └── ...
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   │
│   └── modules/
│       ├── vpc/
│       ├── security-group/
│       ├── iam/
│       ├── alb/
│       ├── launch-template/
│       ├── autoscaling/
│       ├── jenkins/
│       ├── bastion/
│       ├── ecr/
│       ├── s3/
│       └── rds/
│
├── scripts/
│   └── deploy.sh
│
├── docker-compose.yml
├── Jenkinsfile
├── .env
└── README.md
```






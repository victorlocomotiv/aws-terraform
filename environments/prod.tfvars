aws_region           = "us-east-2"
aws_profile          = "production"
vpc_cidr             = "10.27.0.0/22"
availability_zones   = ["us-east-2a", "us-east-2b"]
public_subnet_cidrs  = ["10.27.0.0/24", "10.27.1.0/24"]
private_subnet_cidrs = ["10.27.2.0/24", "10.27.3.0/24"]
domain_name          = "example.com"
subdomain            = "alb.example.com"
certificate_arn      = "arn:aws:acm:us-east-2:123456789012:certificate/uuid"
environment          = "prod"

tags = {
  Environment = "prod"
  Terraform   = "true"
  Project     = "infrastructure"
}
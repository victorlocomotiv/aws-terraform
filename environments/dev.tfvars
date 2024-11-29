aws_region           = "us-east-1"
aws_profile          = "development"
vpc_cidr             = "10.26.0.0/22"
availability_zones   = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.26.0.0/24", "10.26.1.0/24"]
private_subnet_cidrs = ["10.26.2.0/24", "10.26.3.0/24"]
domain_name          = "dev.example.com"
subdomain            = "alb.dev.example.com"
certificate_arn      = "arn:aws:acm:us-east-1:730335407632:certificate/590b25a3-14a0-4881-91d3-20965e2e1d20"
environment          = "dev"

tags = {
  Environment = "dev"
  Terraform   = "true"
  Project     = "infrastructure"
}
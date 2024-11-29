terraform {
  required_version = ">= 1.0"

  backend "s3" {
    # These values will be provided during initialization using workspace config file
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = "true"
    }
  }
}
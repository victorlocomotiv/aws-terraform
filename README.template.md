# AWS Infrastructure

This repository contains Terraform configurations for AWS infrastructure deployment including VPC, ALB, and Route53 resources.

## Infrastructure Architecture

This diagram shows the high-level infrastructure components and their relationships:

![Infrastructure Diagram](docs/simplified-graph.png)

## Environment Setup

The infrastructure can be deployed to different environments (development and production) using Terraform workspaces and environment-specific variable files.

### Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate profiles:
  - `development` profile for dev environment
  - `production` profile for prod environment
- S3 bucket and DynamoDB table for Terraform state (shared between environments)

### Environment-specific Variables
Variables for each environment are stored in:
- Development: `environments/dev.tfvars`
- Production: `environments/prod.tfvars`

### Backend Configuration
Backend configuration for each environment:
- Development: `config/backend-dev.hcl`
- Production: `config/backend-prod.hcl`

## Usage

1. Initialize Terraform with the appropriate backend configuration:
```bash
# For development
terraform init -backend-config=config/backend-dev.hcl
# or
make init ENV=dev

# For production
terraform init -backend-config=config/backend-prod.hcl
# or
make init ENV=prod
```

2. Select the workspace:
```bash
# For development
terraform workspace select dev || terraform workspace new dev

# For production
terraform workspace select prod || terraform workspace new prod
```

3. Plan the changes:
```bash
# For development
terraform plan -var-file=environments/dev.tfvars
# or
make plan ENV=dev

# For production
terraform plan -var-file=environments/prod.tfvars
# or
make plan ENV=prod
```

4. Apply the changes:
```bash
# For development
terraform apply -var-file=environments/dev.tfvars
# or
make apply ENV=dev

# For production
terraform apply -var-file=environments/prod.tfvars
# or
make apply ENV=prod
```

## Contributing

Please read our [Contributing Guide](CONTRIBUTING.md) for details on our development setup and guidelines.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Infrastructure Cost

<!-- BEGIN_COST -->
<!-- END_COST -->

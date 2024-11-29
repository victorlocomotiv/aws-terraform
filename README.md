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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.78.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | git::https://github.com/terraform-aws-modules/terraform-aws-alb.git | 5121d715c42a2b63b0e02d41f675e5c5dd73ef50 |
| <a name="module_alb_security_group"></a> [alb\_security\_group](#module\_alb\_security\_group) | git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git | eb9fb97125c6fd9556287193150a628cdddf5c4d |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git | 9ffd9c66f3d7eb4b5bc2d7bc7d049f794b127693 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.route53_query_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.route53_query_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_kms_key.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.route53](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_route53_hosted_zone_dnssec.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_query_log.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_query_log) | resource |
| [aws_route53_record.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS profile | `string` | `"terraform-profile"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN of ACM certificate | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for Route53 | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | List of private subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | List of public subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | Subdomain for ALB | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR block | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS name of the load balancer |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | Route53 zone ID of the load balancer |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of private subnet IDs |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of public subnet IDs |
| <a name="output_route53_name_servers"></a> [route53\_name\_servers](#output\_route53\_name\_servers) | Route53 zone name servers |
| <a name="output_route53_zone_id"></a> [route53\_zone\_id](#output\_route53\_zone\_id) | Route53 zone ID |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | ARN of the target group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
<!-- END_TF_DOCS -->

## Infrastructure Cost

<!-- BEGIN_COST -->
```
Project: main

 Name                                               Monthly Qty  Unit                    Monthly Cost   
                                                                                                        
 module.vpc.aws_nat_gateway.this[0]                                                                     
 ├─ NAT gateway                                             730  hours                         $32.85   
 └─ Data processed                            Monthly cost depends on usage: $0.045 per GB              
                                                                                                        
 module.vpc.aws_nat_gateway.this[1]                                                                     
 ├─ NAT gateway                                             730  hours                         $32.85   
 └─ Data processed                            Monthly cost depends on usage: $0.045 per GB              
                                                                                                        
 module.alb.aws_lb.this[0]                                                                              
 ├─ Application load balancer                               730  hours                         $16.43   
 └─ Load balancer capacity units              Monthly cost depends on usage: $5.84 per LCU              
                                                                                                        
 aws_kms_key.cloudwatch                                                                                 
 ├─ Customer master key                                       1  months                         $1.00   
 ├─ Requests                                  Monthly cost depends on usage: $0.03 per 10k requests     
 ├─ ECC GenerateDataKeyPair requests          Monthly cost depends on usage: $0.10 per 10k requests     
 └─ RSA GenerateDataKeyPair requests          Monthly cost depends on usage: $0.10 per 10k requests     
                                                                                                        
 aws_kms_key.route53                                                                                    
 ├─ Customer master key                                       1  months                         $1.00   
 └─ Requests (asymmetric)                     Monthly cost depends on usage: $0.15 per 10k requests     
                                                                                                        
 aws_route53_zone.main                                                                                  
 └─ Hosted zone                                               1  months                         $0.50   
                                                                                                        
 aws_cloudwatch_log_group.route53_query_logs                                                            
 ├─ Data ingested                             Monthly cost depends on usage: $0.50 per GB               
 ├─ Archival Storage                          Monthly cost depends on usage: $0.03 per GB               
 └─ Insights queries data scanned             Monthly cost depends on usage: $0.005 per GB              
                                                                                                        
 aws_route53_record.alb                                                                                 
 ├─ Standard queries (first 1B)               Monthly cost depends on usage: $0.40 per 1M queries       
 ├─ Latency based routing queries (first 1B)  Monthly cost depends on usage: $0.60 per 1M queries       
 └─ Geo DNS queries (first 1B)                Monthly cost depends on usage: $0.70 per 1M queries       
                                                                                                        
 OVERALL TOTAL                                                                                $84.63 

*Usage costs can be estimated by updating Infracost Cloud settings, see docs for other options.

──────────────────────────────────
41 cloud resources were detected:
∙ 8 were estimated
∙ 30 were free
∙ 3 are not supported yet, rerun with --show-skipped to see details

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃           $85 ┃           - ┃        $85 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛ 
```
<!-- END_COST -->

## License

[MIT](LICENSE)

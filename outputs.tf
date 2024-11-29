output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "nat_eip_ids" {
  description = "List of NAT Gateway EIP allocation IDs"
  value       = aws_eip.nat[*].id
}

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.alb.dns_name
}

output "alb_zone_id" {
  description = "Route53 zone ID of the load balancer"
  value       = module.alb.zone_id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.alb.target_groups["main"].arn
}

output "route53_zone_id" {
  description = "Route53 zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "route53_name_servers" {
  description = "Route53 zone name servers"
  value       = aws_route53_zone.main.name_servers
}

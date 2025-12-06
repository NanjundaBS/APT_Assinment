output "alb_dns" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}


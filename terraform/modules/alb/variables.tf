variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "alb_sg_id" { type = string }
variable "target_port" { type = number }
variable "project" { type = string }
variable "enable_https" { type = bool }
variable "certificate_arn" { type = string }

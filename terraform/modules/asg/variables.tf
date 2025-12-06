variable "project" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "instance_type" { type = string }
variable "desired_capacity" { type = number }
variable "alb_target_group_arn" { type = string }
variable "iam_instance_profile" { type = string }
variable "ec2_sg_id" { type = string }
variable "app_port" { 
    type = number
    default = 8080 
    }
variable "ami_id" { 
    type = string
     default = "" 
     }

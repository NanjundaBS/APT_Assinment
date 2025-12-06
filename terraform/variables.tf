variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "(optional) AWS CLI profile name"
  type        = string
  default     = ""
}

variable "project" {
  description = "Project name prefix"
  type        = string
  default     = "oneclick"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "asg_desired_capacity" {
  type    = number
  default = 2
}

variable "ssh_cidr" {
  description = "If you absolutely need SSH; set to single /32. Leave empty to disable SSH port opening."
  type        = string
  default     = ""
}

variable "alb_enable_https" {
  description = "Whether to create HTTPS listener (requires certificate ARN). Default false."
  type        = bool
  default     = false
}

# optional override for AMI (if blank we use Amazon Linux 2 latest)
variable "ami_id" {
  description = "Optional specific AMI id (ami-... )"
  type        = string
  default     = ""
}

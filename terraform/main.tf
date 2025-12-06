module "vpc" {
  source         = "./modules/vpc"
  project        = var.project
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "security_groups" {
  source      = "./modules/security_groups"
  vpc_id      = module.vpc.vpc_id
  project     = var.project
  target_port = 8080
  ssh_cidr    = var.ssh_cidr
}

module "iam" {
  source  = "./modules/iam"
  project = var.project
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
  target_port       = 8080
  project           = var.project
  enable_https      = var.alb_enable_https
  certificate_arn   = "" # not used in this variant (we're not enabling HTTPS)
}

module "asg" {
  source               = "./modules/asg"
  project              = var.project
  private_subnet_ids   = module.vpc.private_subnet_ids
  instance_type        = var.instance_type
  desired_capacity     = var.asg_desired_capacity
  alb_target_group_arn = module.alb.target_group_arn
  iam_instance_profile = module.iam.instance_profile_name
  ec2_sg_id            = module.security_groups.ec2_sg_id
  app_port             = 8080
  ami_id               = var.ami_id
}

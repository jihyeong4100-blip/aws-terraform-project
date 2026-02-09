provider "aws" {
  region = var.region
}

module "vpc" {
  source       = "./modules/vpc"
  region       = var.region
  project_name = var.project_name
}

module "security_groups" {
  source       = "./modules/security_groups"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

module "ec2_instance" {
  source           = "./modules/ec2_instance"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.public_subnet_1_id
  security_group_ids = [module.security_groups.ec2_security_group_id]
  region           = var.region
  project_name     = var.project_name
  ami              = var.ami
  instance_type    = var.instance_type
  key_pair_name    = var.key_pair_name
  public_key_path  = var.public_key_path
}

module "rds" {
  source               = "./modules/rds"
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  rds_security_group_ids = [module.security_groups.rds_security_group_id]
  db_password          = var.db_password
  project_name         = var.project_name
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "cloudwatch_dashboard" {
  source                   = "./modules/cloudwatch_dashboard"
  project_name             = var.project_name
  ec2_instance_id          = module.ec2_instance.instance_id
  ec2_instance_type        = var.instance_type
  rds_db_instance_identifier = module.rds.rds_identifier
  region                   = var.region
}
variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-northeast-2"
}

variable "project_name" {
  description = "Name of the project, used for resource tagging"
  type        = string
  default     = "jjh"
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0e9bfdb247cc8de84" # Ubuntu 20.04 LTS HVM EBS optimized in ap-northeast-2
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "jjh-key"
}

variable "public_key_path" {
  description = "Path to the public key file for SSH access"
  type        = string
  default     = "./jjh-key.pub"
}

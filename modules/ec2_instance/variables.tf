variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the public subnet for the EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs for the EC2 instance"
  type        = list(string)
}

variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "project_name" {
  description = "Name of the project, used for resource tagging"
  type        = string
  default     = "jjh"
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0e9bfdb247cc8de84"
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

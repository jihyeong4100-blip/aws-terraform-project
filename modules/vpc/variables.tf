variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr_block" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "public_subnet_2_cidr_block" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}

variable "project_name" {
  description = "Name of the project, used for resource tagging"
  type        = string
  default     = "jjh"
}

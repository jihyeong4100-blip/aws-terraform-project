variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the RDS instance"
  type        = list(string)
}

variable "rds_security_group_ids" {
  description = "A list of security group IDs for the RDS instance"
  type        = list(string)
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Name of the project, used for resource tagging"
  type        = string
  default     = "jjh"
}

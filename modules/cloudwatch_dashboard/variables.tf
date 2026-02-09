variable "project_name" {
  description = "Name of the project, used for resource tagging"
  type        = string
  default     = "jjh"
}

variable "ec2_instance_id" {
  description = "The ID of the EC2 instance to monitor"
  type        = string
}

variable "ec2_instance_type" {
  description = "The type of the EC2 instance to monitor"
  type        = string
}

variable "rds_db_instance_identifier" {
  description = "The identifier of the RDS DB instance to monitor"
  type        = string
}

variable "region" {
  description = "AWS region for deployment"
  type        = string
}

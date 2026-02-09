variable "vpc_id" {
  description = "The ID of the VPC to associate security groups with"
  type        = string
}

variable "project_name" {
  description = "Name of the project, used for resource tagging"
  type        = string
  default     = "jjh"
}

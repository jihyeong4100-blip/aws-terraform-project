output "public_ip" {
  description = "The public IP address of the deployed EC2 instance."
  value       = module.ec2_instance.public_ip
}

output "ssh_command" {
  description = "An example SSH command to connect to the EC2 instance."
  value       = module.ec2_instance.ssh_command
}

output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = module.ec2_instance.instance_id
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository."
  value       = module.ecr.ecr_repository_url
}

output "rds_endpoint" {
  description = "The endpoint for the RDS MySQL database."
  value       = module.rds.rds_endpoint
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_eip.app.public_ip
}

output "ssh_command" {
  description = "SSH command to connect to the EC2 instance"
  value       = "ssh -i ${path.module}/jjh-key.pem ubuntu@${aws_eip.app.public_ip}"
}

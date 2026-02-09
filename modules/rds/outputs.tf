output "rds_endpoint" {
  description = "The endpoint for the RDS MySQL database"
  value       = aws_db_instance.portfolio.endpoint
}

output "rds_identifier" {
  description = "The identifier for the RDS MySQL database"
  value       = aws_db_instance.portfolio.identifier
}

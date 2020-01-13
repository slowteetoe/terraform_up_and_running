output "address" {
  value       = aws_db_instance.example.address
  description = "connection address for database"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "listening port for database"
}

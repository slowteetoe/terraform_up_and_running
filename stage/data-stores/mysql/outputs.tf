output "db_host" {
  value       = module.db_module.address
  description = "connection address for database"
}

output "db_port" {
  value       = module.db_module.port
  description = "listening port for database"
}

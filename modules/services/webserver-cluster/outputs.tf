output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "domain name of the load balancer"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The loadbalancer security group ID"
}

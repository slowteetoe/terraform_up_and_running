output "load_balancer_url" {
  value       = module.webserver_cluster.alb_dns_name
  description = "domain name of the load balancer"
}

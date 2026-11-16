output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.main.id
}

output "web_instance_id" {
  description = "ID of the web-tier EC2 instance."
  value       = aws_instance.web.id
}

output "app_instance_id" {
  description = "ID of the private application-tier EC2 instance."
  value       = aws_instance.app.id
}

output "load_balancer_url" {
  description = "Public DNS name of the application load balancer."
  value       = "http://${aws_lb.web.dns_name}"
}

output "rds_endpoint" {
  description = "Private endpoint of the RDS database."
  value       = aws_db_instance.main.address
}

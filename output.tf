output "sg_lb" {
  value       = aws_security_group.lb.id
  description = "security group for loadbalancer"
}

output "sg_ecs" {
  value       = aws_security_group.ecs_tasks.id
  description = "security group for ecs"
}

output "sg_rds" {
  value       = aws_security_group.db.id
  description = "security group for rds"
}
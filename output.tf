output "sg_lb" {
  description = "security group for loadbalancer"
  value       = aws_security_group.lb.id
}

output "sg_ecs" {
  description = "security group for ecs"
  value       = aws_security_group.ecs_tasks.id
}

output "sg_rds" {
  description = "security group for rds"
  value       = aws_security_group.db.id
}
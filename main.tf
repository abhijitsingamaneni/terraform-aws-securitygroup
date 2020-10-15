

# ALB security group 
resource "aws_security_group" "lb" {
  name        = "lb-sg-curai-${var.env}-${var.application}"
  description = "controls access to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sg-curai-${var.env}-${var.application}"
  }
}

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
  name        = "ecs-sg-curai-${var.env}-${var.application}"
  description = "allow inbound access from the ALB only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-sg-curai-${var.env}-${var.application}"
  }
}

resource "aws_security_group" "db" {
  name        = "db-sg-curai-${var.env}-${var.application}"
  description = "allow inbound access to database"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 5432
    to_port         = 5432
    security_groups = [aws_security_group.ecs_tasks.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg-curai-${var.env}-${var.application}"
  }
}

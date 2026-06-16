resource "aws_security_group" "rds" {
  name        = "gocart-rds-sg"
  description = "Security group for GoCart RDS database"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow PostgreSQL traffic from EKS worker nodes"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "gocart-rds-sg"
    Environment = var.environment
  }
}

resource "aws_db_instance" "postgres" {
  identifier            = "gocart-prod-db"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"
  engine                = "postgres"
  engine_version        = "15"
  instance_class        = "db.t3.micro" # Cost-effective for dev/prod-demostration; can be scaled to db.m6g.large for enterprise workloads
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password
  parameter_group_name  = "default.postgres15"

  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds.id]

  storage_encrypted   = true
  skip_final_snapshot = true
  multi_az            = false # Toggle to true for Multi-AZ production redundancy

  tags = {
    Environment = var.environment
    Project     = "gocart"
  }
}

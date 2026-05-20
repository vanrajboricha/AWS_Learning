resource "aws_db_instance" "orders_postgres" {
  identifier              = "orders-postgres-db"
  engine                  = "postgres"
  engine_version          = "17.6"
  instance_class          = "db.t4g.micro"
  allocated_storage       = 20
  max_allocated_storage   = 100
  db_subnet_group_name = aws_db_subnet_group.postgres_sqs_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_postgres_sg.id]

  db_name                 = "ordersdb"
  username                = local.retailstore_secret_json.username 
  password                = local.retailstore_secret_json.password

  multi_az                = false
  storage_encrypted       = true
  publicly_accessible     = false
  skip_final_snapshot     = true

  backup_retention_period = 7
  deletion_protection     = false

  tags = var.tags
}

output "orders_rds_postgresql_endpoint" {
  description = "PostgreSQL RDS endpoint for Orders microservice"
  value       = aws_db_instance.orders_postgres.endpoint
}

output "orders_rds_postgresql_db_name" {
  value       = aws_db_instance.orders_postgres.db_name
}
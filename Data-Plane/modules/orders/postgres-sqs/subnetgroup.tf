resource "aws_db_subnet_group" "postgres_sqs_subnet_group" {
  name = "postgres-sqs-subnet_group"
  subnet_ids = var.private_subnet_ids
  tags = var.tags
}
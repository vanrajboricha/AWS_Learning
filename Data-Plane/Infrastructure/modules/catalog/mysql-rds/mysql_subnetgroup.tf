resource "aws_db_subnet_group" "rds_private" {
  name = "vanbor-rds-private-subnet"
  subnet_ids = var.private_subnet_ids
  tags = var.tags
}
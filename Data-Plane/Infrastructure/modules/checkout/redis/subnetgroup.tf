resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "vanbor-redis-subnet-group"
  subnet_ids = var.private_subnet_ids
}
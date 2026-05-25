resource "aws_elasticache_cluster" "checkout_redis" {
  engine = "redis"
  node_type = "cache.t3.micro"
  cluster_id = "vanbor-checkout-redis"
  security_group_ids = [aws_security_group.redis-sg.id]
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  engine_version       = "7.1"
  parameter_group_name = "default.redis7"
  tags = var.tags
  num_cache_nodes   = 1
}

output "checkout_redis_endpoint" {
  value = aws_elasticache_cluster.checkout_redis.cache_nodes[0].address
}
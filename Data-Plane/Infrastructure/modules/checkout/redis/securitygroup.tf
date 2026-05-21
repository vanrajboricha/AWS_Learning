resource "aws_security_group" "redis-sg" {
  name = "redis-sg"
  description = "Allow EKS cluster to communicate with Redis"
  vpc_id = var.vpc_id

  ingress {
    from_port                = 6379
    to_port                  = 6379
    protocol                 = "tcp"
    security_groups          = var.eks_cluster_security_group_id
    description              = "Allow traffic from EKS cluster SG"
  }



tags = var.tags

}
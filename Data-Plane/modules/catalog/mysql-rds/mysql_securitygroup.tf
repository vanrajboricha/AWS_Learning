resource "aws_security_group" "rds_mysql_sg" {
  name = "rds-mysql-sg"
  description = "MYSQL security Group"
  vpc_id = var.vpc_id
  ingress {
    description = "Allow MySQL from EKS cluster security group"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = var.eks_cluster_security_group_id
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name}-rds-mysql-sg"
  }
} 
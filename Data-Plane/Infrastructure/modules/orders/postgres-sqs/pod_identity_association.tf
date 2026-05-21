resource "aws_eks_pod_identity_association" "orders" {
  cluster_name = var.cluster_name
  namespace = "default"
  role_arn = aws_iam_role.postgres_getsecrets.arn
  service_account = "orders"
}

output "orders_postgresql_sa_pod_identity_association_arn" {
  description = "Pod Identity Association ARN for Orders PostgreSQL ServiceAccount (used for AWS Secrets Manager access)"
  value       = aws_eks_pod_identity_association.orders.association_arn
}
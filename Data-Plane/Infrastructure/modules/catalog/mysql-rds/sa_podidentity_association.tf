resource "aws_eks_pod_identity_association" "catalog" {
  cluster_name    = var.cluster_name
  namespace       = "default"
  service_account = "catalog"
  role_arn        = aws_iam_role.catalog_getsecrets.arn
}

output "catalog_sa_podidentity_association" {
  value = aws_eks_pod_identity_association.catalog.association_arn
}
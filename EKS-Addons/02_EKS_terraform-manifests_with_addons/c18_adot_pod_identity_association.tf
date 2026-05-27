resource "aws_eks_pod_identity_association" "adot_collector" {
  cluster_name = aws_eks_cluster.main.name
  namespace       = "default"
  service_account = "adot-collector"
  role_arn        = aws_iam_role.adot_collector.arn
  tags = var.tags
}
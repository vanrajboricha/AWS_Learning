resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = local.eks_cluster_name
  addon_name   = "eks-pod-identity-agent"

  # Optional:
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.tags
}

resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name = local.eks_cluster_name
  addon_name   = "aws-ebs-csi-driver"

  # Optional:
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.tags
}

data "aws_eks_addon_version" "pia_default" {
  addon_name = "eks-pod-identity-agent"
  kubernetes_version = aws_eks_cluster.main.version
}

data "aws_eks_addon_version" "pia_latest" {
  addon_name = "eks-pod-identity-agent"
  kubernetes_version = aws_eks_cluster.main.version
}


resource "aws_eks_addon" "podidentity" {
  depends_on = [ aws_eks_node_group.private_nodes ]
  cluster_name = aws_eks_cluster.main.id
  addon_name = "eks-pod-identity-agent"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  addon_version = data.aws_eks_addon_version.pia_latest.version
}

output "pod_identity_agent_eksaddon_default_version" {
  value = data.aws_eks_addon_version.pia_default
}

output "pod_identity_agent_eksaddon_latest_version" {
  value = data.aws_eks_addon_version.pia_latest
}

output "pod_identity_agent_eksaddon_arn" {
  value = aws_eks_addon.podidentity.arn
}
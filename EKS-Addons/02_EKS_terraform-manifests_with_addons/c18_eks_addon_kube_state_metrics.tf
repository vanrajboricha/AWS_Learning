data "aws_eks_addon_version" "kube_state_metrics_default" {
  addon_name         = "kube-state-metrics"
  kubernetes_version = aws_eks_cluster.main.version
}

data "aws_eks_addon_version" "kube_state_metrics_latest" {
  addon_name         = "kube-state-metrics"
  kubernetes_version = aws_eks_cluster.main.version
  most_recent        = true
}


resource "aws_eks_addon" "kube_state_metrics" {
  cluster_name = aws_eks_cluster.main.id
  addon_name    = "kube-state-metrics"
  addon_version = data.aws_eks_addon_version.kube_state_metrics_latest.version  
  # Conflict resolution
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags = var.tags
}

output "kube_state_metrics_addon_id" {
  description = "Kube State Metrics EKS Addon ID"
  value       = aws_eks_addon.kube_state_metrics.id
}

output "kube_state_metrics_version" {
  description = "Kube State Metrics EKS Addon Version"
  value       = aws_eks_addon.kube_state_metrics.addon_version
}
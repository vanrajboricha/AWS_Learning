data "aws_eks_addon_version" "prometheus_node_exporter_latest" {
  addon_name         = "prometheus-node-exporter"
  kubernetes_version = aws_eks_cluster.main.version
  most_recent        = true
}

# EKS Add-on: Prometheus Node Exporter 
resource "aws_eks_addon" "prometheus_node_exporter" {
  cluster_name = aws_eks_cluster.main.id
  addon_name    = "prometheus-node-exporter"
  addon_version = data.aws_eks_addon_version.prometheus_node_exporter_latest.version  
  # Conflict resolution
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  tags = var.tags
}


# Outputs
output "prometheus_node_exporter_addon_id" {
  description = "Prometheus Node Exporter EKS Addon ID"
  value       = aws_eks_addon.prometheus_node_exporter.id
}

output "prometheus_node_exporter_addon_version" {
  description = "Prometheus Node Exporter EKS Addon Version"
  value       = aws_eks_addon.prometheus_node_exporter.addon_version
}
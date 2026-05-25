data "aws_eks_addon_version" "metrics_server_latest" {
    addon_name = "metrics-server"
    kubernetes_version = aws_eks_cluster.main.version
    most_recent = true
}

resource "aws_eks_addon" "metrics_server" {
  addon_version = data.aws_eks_addon_version.metrics_server_latest.version
  addon_name = "metrics-server"
  cluster_name = aws_eks_cluster.main.id
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}


output "metrics_server_latest" {
  description = "metrics server latest version"
  value = data.aws_eks_addon_version.metrics_server_latest.version
}

output "metrics_server_eks_addon_arn" {
  description = "metrics server name"
  value = aws_eks_addon.metrics_server.arn
}

output "metrics_server_eks_addon_id" {
  description = "metrics server name"
  value = aws_eks_addon.metrics_server.id
}
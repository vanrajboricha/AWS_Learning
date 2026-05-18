#############################################
# Launch Template for EC2 Worker Node Tags
#############################################

resource "aws_launch_template" "eks_nodes" {

  name_prefix = "${local.name}-eks-node-lt"

  #########################################
  # ROOT VOLUME CONFIGURATION
  #########################################

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {
      volume_size = var.node_disk_size
      volume_type = "gp3"
      encrypted   = true
    }
  }

  #########################################
  # TAGS FOR EC2 INSTANCES
  #########################################

  tag_specifications {

    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "${local.name}-eks-worker-node"
      }
    )
  }
  
}
resource "aws_eks_node_group" "private_nodes" {
  cluster_name = aws_eks_cluster.main.name
  node_group_name = "${local.name}-private-ng"
  node_role_arn = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  instance_types = var.node_instance_types
  capacity_type = var.node_capacity_type
  ami_type = "AL2023_x86_64_STANDARD"
  #disk_size = var.node_disk_size
  #########################################
  # ATTACH LAUNCH TEMPLATE
  #########################################

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = "$Latest"
  }
  scaling_config {
    desired_size = 3
    min_size = 1
    max_size = 6
  }
  update_config {
    max_unavailable_percentage = 33
  }
  force_update_version = true
  labels = {
    "env" = var.environment_name
    "team" = var.business_division
  }
  tags = merge(var.tags, {
    Name = "${local.name}-private-ng"
    Environment = var.environment_name
  })
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy
  ]

}
data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "tfstate-vanbor-s3-ap-south-1-t4hb"
    key    = "eks/dev/terraform.tfstate"
    region = var.aws_region
  }
}

output "eks_cluster_name" {
  value = data.terraform_remote_state.eks.outputs.eks_cluster_name
}

output "eks_cluster_id" {
  value = data.terraform_remote_state.eks.outputs.eks_cluster_id
}
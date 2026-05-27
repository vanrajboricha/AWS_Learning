# Data Source: AWS Account Info
data "aws_caller_identity" "current" {}

# Data Source: AWS Region
data "aws_region" "current" {}

# Data Source: AWS Partition
data "aws_partition" "current" {}

locals {
  owners = var.business_division

  environment = var.environment_name

  name = "${local.owners}-${local.environment}"

  eks_cluster_name = "${local.name}-${var.cluster_name}"

  account_id = data.aws_caller_identity.current.account_id
}

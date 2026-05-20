data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  bu = var.business_division

  environment = var.environment_name

  owners= var.created_person

  name = "${local.bu}-${local.environment}-${local.owners}"
}
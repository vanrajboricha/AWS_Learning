data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "tfstate-vanbor-s3-ap-south-1-t4hb"
    key    = "vpc/dev/terraform.tfstate"
    region = var.aws_region
  }
}

output "vpc_id" {
    value = data.terraform_remote_state.vpc.outputs.aws_vpc
}

output "public_subnet_ids" {
    value = data.terraform_remote_state.vpc.outputs.public_subnet_ids
}

output "private_subnet_ids" {
    value = data.terraform_remote_state.vpc.outputs.private_subnet_ids
}

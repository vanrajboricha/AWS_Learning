terraform {
  required_version = ">= 1.12.0"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 6.0"
    }
  }



  ##Remote backend configuration using S3
  backend "s3" {
    bucket = "tfstate-vanbor-s3-ap-south-1-t4hb"
    key = "eks/dev/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}
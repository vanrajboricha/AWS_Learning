#Data Block
data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_vpc" "main" {
  id = "vpc-02358ddc1cb955bcd"
}

data "aws_internet_gateway" "igw" {
  internet_gateway_id = "igw-095a43d99a5ec72d6"
}

data "aws_nat_gateway" "nat" {
  vpc_id = "vpc-02358ddc1cb955bcd"
  state = "available"
  #subnet_id = aws_subnet.private.id
  tags = {
    Name = "vanbor_NAT_GW"
  }
}

#locals {
#  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
#  private_subnets = [for k, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbits, k + 10)]
#}

locals {
  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.124.0/24", "10.0.224.0/24"]   
}


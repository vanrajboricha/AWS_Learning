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
  #nat_gateway_id = "nat-054be5efc41467fef"
}




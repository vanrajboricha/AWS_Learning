resource "aws_subnet" "public" {  
  for_each = { for idx, az in local.azs : az => local.public_subnets[idx] }
  vpc_id     = data.aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key
  tags = merge(var.tags, {
    Name = "vanbor-subnet-public-${each.key}"
  })
}

resource "aws_subnet" "private" {
  for_each = { for idx, az in local.azs : az => local.private_subnets[idx] }

  vpc_id     = data.aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key
  tags = merge(var.tags, {
    Name = "vanbor-subnet-private-${each.key}"
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.main.id  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Name = "vanbor-public-rt" })
}

resource "aws_route_table_association" "public_rt_assoc" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = data.aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }
  tags = merge(var.tags, { Name = "vanbor-private-rt" })
}

resource "aws_route_table_association" "private_rt_assoc" {
  for_each = aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_rt.id
}
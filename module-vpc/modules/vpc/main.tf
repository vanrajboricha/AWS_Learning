resource "aws_subnet" "public" {  
  vpc_id                  = data.aws_vpc.main.id
  cidr_block              = "10.0.24.0/24"
  tags = merge(var.tags, {
    Name = "vanbor-subnet-public"
  })
}

resource "aws_subnet" "private" {  
  vpc_id                  = data.aws_vpc.main.id
  cidr_block              = "10.0.124.0/24"
  tags = merge(var.tags, {
    Name = "vanbor-subnet-private"
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
  subnet_id      = aws_subnet.public.id
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
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}
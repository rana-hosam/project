provider "aws"{
region = "us-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
   tags = {
    Name = "Terra_vpc"
  }
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "subnet1"
  }
}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "subnet2"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "gateway"
  }
}
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "route_table"
  }
}

output "RT_name" {
value = aws_route_table.RT.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.RT.id
}


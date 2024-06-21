resource "aws_vpc" "cs4-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  instance_tenancy     = "default"

  tags = {
    Name = "cs4_vpc"
  }
}

resource "aws_subnet" "subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.cs4-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.cs4-vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = "Public-${var.subnet_names[count.index]}"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.cs4-vpc.id
  tags = {
    Name = "cs4_internet_gateway"
  }
}

resource "aws_route_table" "cs4-public-route" {
  vpc_id = aws_vpc.cs4-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "subnet-assoc" {
  count          = length(var.availability_zones)
  route_table_id = aws_route_table.cs4-public-route.id
  subnet_id      = aws_subnet.subnets[count.index].id

}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.cs4-vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "My_security_group"
  }
}

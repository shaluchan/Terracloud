
#creating a VPC for private instances
resource "aws_vpc" "app_vpc" {
    cidr_block = "172.32.0.0/16"
    tags = {
      Name = "app_vpc"
    }
}
#creating public subnets
resource "aws_subnet" "public_subnet_1" {
    cidr_block = "172.32.0.0/24"
    vpc_id = aws_vpc.app_vpc.id
    availability_zone = "eu-north-1a"
    tags = {
      Name="public_subnet_1"
    }
}
  resource "aws_subnet" "public_subnet_2" {
    cidr_block = "172.32.1.0/24"
    vpc_id = aws_vpc.app_vpc.id
    availability_zone = "eu-north-1b"
    tags = {
      Name="public_subnet_2"
    }
}
#Private subnet
resource "aws_subnet" "private_subnet_1" {
  cidr_block = "172.32.2.0/24"
  vpc_id     = aws_vpc.app_vpc.id
  availability_zone = "eu-north-1a"
  tags = {
    Name = "private-subnet-1"
  }
}
resource "aws_subnet" "private_subnet_2" {
  cidr_block = "172.32.3.0/24"
  vpc_id     = aws_vpc.app_vpc.id
  availability_zone = "eu-north-1b"
  tags = {
    Name = "private-subnet-2"
  }
}
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.app_vpc.id
    tags = {
        Name ="my_igw"
    }
  
}
resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.app_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
}
    route {
        cidr_block = "192.168.0.0/16"
        transit_gateway_id= aws_ec2_transit_gateway.tgw.id
        }
    
    tags = {
    Name = "public_route_table"
}
   depends_on  = [aws_ec2_transit_gateway.tgw]
}
resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.app_vpc.id
  route {
        cidr_block = "192.168.0.0/16"
        transit_gateway_id= aws_ec2_transit_gateway.tgw.id
        }
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw.id
        }
  tags = {
    Name = "private_route_table"
  }
}
resource "aws_route_table_association" "public_subnet_1" {
    route_table_id = aws_route_table.public_route.id
    subnet_id = aws_subnet.public_subnet_1.id
}
resource "aws_route_table_association" "public_subnet_2" {
    route_table_id = aws_route_table.public_route.id
    subnet_id = aws_subnet.public_subnet_2.id
}
resource "aws_route_table_association" "private_subnet_1" {
  route_table_id = aws_route_table.private_route.id
  subnet_id = aws_subnet.private_subnet_1.id
}
resource "aws_route_table_association" "private_subnet_2" {
  route_table_id = aws_route_table.private_route.id
  subnet_id = aws_subnet.private_subnet_2.id
}

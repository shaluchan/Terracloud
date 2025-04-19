terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws"{
    region = "eu-north-1"
}

#creating a VPC for bastion host
resource "aws_vpc" "bastion_vpc" {
    cidr_block = "192.168.0.0/16"
    tags = {
      Name = "bastion_vpc"
    }
}

#creating a public subnet
resource "aws_subnet" "public_subnet" {
    cidr_block = "192.168.1.0/24"
    vpc_id = aws_vpc.bastion_vpc.id
    tags = {
      Name="public_subnet"
    }
}

#creating internet gateway
resource "aws_internet_gateway" "my_bastion_igw" {
    vpc_id = aws_vpc.bastion_vpc.id
    tags = {
        Name ="my_igw"
    }
}
#creating a route table
resource "aws_route_table" "bastion_route" {
    vpc_id = aws_vpc.bastion_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_bastion_igw.id
    }
     route {
        cidr_block = "172.32.0.0/16"
        transit_gateway_id= aws_ec2_transit_gateway.tgw.id
        }
    }
 resource "aws_route_table_association" "public_subnet" {
    route_table_id = aws_route_table.bastion_route.id
    subnet_id = aws_subnet.public_subnet.id
 }

resource "aws_ec2_transit_gateway" "tgw" {
    description = "transit gateway for connecting both vpcs"
    tags = {
        Name = "My TGW"
    }
  
}
resource "aws_ec2_transit_gateway_vpc_attachment" "bastion_vpc_attachment" {
    subnet_ids         = [aws_subnet.public_subnet.id]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
    vpc_id             = aws_vpc.bastion_vpc.id
    tags={
        Name="bastion_vpc_attachment"
    }
  }
  resource "aws_ec2_transit_gateway_vpc_attachment" "app_vpc_attachment" {
    subnet_ids         = [aws_subnet.public_subnet_1.id,aws_subnet.private_subnet_2.id]
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
    vpc_id             = aws_vpc.app_vpc.id
    tags={
        Name="app_vpc_attachment"
    }
  }

resource "aws_security_group" "common-sg" {
    vpc_id = aws_vpc.app_vpc.id
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["192.168.0.0/16"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "app-sg"
    }
}

    resource "aws_security_group" "bastion-sg" {
        vpc_id = aws_vpc.bastion_vpc.id
        ingress{
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
      
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags={
        Name="bastion-sg"
    }
    }
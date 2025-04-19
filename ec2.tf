resource "aws_instance" "app_instance_1" {
    ami = aws_ami_from_instance.custom_ami.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.private_subnet_1.id
    iam_instance_profile=aws_iam_instance_profile.ec2_profile.name
    security_groups=[aws_security_group.common-sg.id]
    key_name = aws_key_pair.aws_key_pair.key_name
       user_data = <<-EOF
            #!/bin/bash
                sudo mkdir -p /var/www/html/images /var/www/html/css /var/www/html/js
                sudo chmod -R 755 /var/www/html
                sudo chown -R apache:apache /var/www/html
                sudo -u apache aws s3 sync s3://${aws_s3_bucket.app_bucket.bucket}/ /var/www/html/
                sudo systemctl restart httpd
                EOF
    tags = {
        Name = "app_instance_1"
    }
    depends_on = [aws_nat_gateway.nat_gw,aws_ami_from_instance.custom_ami]
}
resource "aws_instance" "app_instance_2" {
    ami = aws_ami_from_instance.custom_ami.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.private_subnet_2.id
    iam_instance_profile=aws_iam_instance_profile.ec2_profile.name
    security_groups=[aws_security_group.common-sg.id]
    key_name = aws_key_pair.aws_key_pair.key_name
    user_data = <<-EOF
            #!/bin/bash
                sudo mkdir -p /var/www/html/images /var/www/html/css /var/www/html/js
                sudo chmod -R 755 /var/www/html
                sudo chown -R apache:apache /var/www/html
                sudo -u apache aws s3 sync s3://${aws_s3_bucket.app_bucket.bucket}/ /var/www/html/
                sudo systemctl restart httpd
                EOF
    tags = {
        Name = "app_instance_2"
    }
    depends_on = [aws_nat_gateway.nat_gw,aws_ami_from_instance.custom_ami]
}
resource "aws_instance" "bastion_instance" {
    ami = aws_ami_from_instance.custom_ami.id
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet.id
    key_name = aws_key_pair.aws_key_pair.key_name
    associate_public_ip_address = true
    security_groups=[aws_security_group.bastion-sg.id]
    tags = {
        Name = "bastion_instance"
    }
    depends_on = [aws_nat_gateway.nat_gw,aws_ami_from_instance.custom_ami]
}
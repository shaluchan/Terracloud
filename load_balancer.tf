#creating a target group
resource "aws_lb_target_group" "app_tg" {
    name        = "app-tg"
    port        = 80
    protocol    = "TCP"
    vpc_id      = aws_vpc.app_vpc.id
    target_type = "instance"
health_check {
    port                = "80"
    protocol            = "TCP"
    timeout             = 5
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
}
tags = {
    Name = "app_tg"
}
}
#register instance with target group
resource "aws_lb_target_group_attachment" "app_tg_attachment_1" {
    target_group_arn = aws_lb_target_group.app_tg.arn
    target_id        = aws_instance.app_instance_1.id
    port             = 80
}
resource "aws_lb_target_group_attachment" "app_tg_attachment_2" {
    target_group_arn = aws_lb_target_group.app_tg.arn
    target_id        = aws_instance.app_instance_2.id
    port             = 80
}
#creating a load balancer
resource "aws_lb" "app_nlb" {
    name               = "app-nlb"
    internal           = false
    load_balancer_type = "network"
    subnets            = [aws_subnet.public_subnet_2.id, aws_subnet.private_subnet_1.id]
    enable_deletion_protection = false
    tags = {
        Name = "app_nlb"
    }
}
#creating a listener
resource "aws_lb_listener" "app_listener" {
    load_balancer_arn = aws_lb.app_nlb.arn
    port              = "80"
    protocol          = "TCP"
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.app_tg.arn
    }
}
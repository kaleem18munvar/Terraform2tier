resource "aws_lb" "vpc_lb" {
  name               = "vpc-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups = ["${aws_security_group.pubsg.id}"]
  subnets            = [aws_subnet.ec2subnet.id, aws_subnet.ec2subnet2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}
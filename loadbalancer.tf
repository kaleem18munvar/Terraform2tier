resource "aws_lb" "vpc_lb" {
  name               = "vpc-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.ec2subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}
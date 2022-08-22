data "aws_availability_zones" "available" {
    state = "available"
  }
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base*"]
  }
  
}

resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = data.aws_ami.windows.id
  instance_type = "t2.micro"
  key_name      = "Terraformfrankfurtorg"
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "asg"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier = [aws_subnet.ec2subnet.id]

  lifecycle {
    create_before_destroy = true
  }
}

#DB Instance
resource "aws_db_subnet_group" "dbsubgrp" {
  name       = "dbsubgrp"
  subnet_ids = [aws_subnet.rdssubnet.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "rds_db" {
  identifier            = "mysql-db-01"  
  allocated_storage     = 5
  availability_zone     = "eu-central-1b"
  publicly_accessible   = false
  vpc_security_group_ids               = [aws_security_group.prisg.id]
  db_subnet_group_name = aws_db_subnet_group.dbsubgrp.name
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "rds_db"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  

  tags = {
    Name = "DBSERVER"
  }
}
resource "aws_db_snapshot" "testdbsnap" {
  db_instance_identifier = aws_db_instance.rds_db.id
  db_snapshot_identifier = "testsnapshot1234"
}
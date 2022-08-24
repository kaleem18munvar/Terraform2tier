
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base*"]
  }
  
}



resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf_key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "tfkey"
}

resource "aws_key_pair" "tf_key"{
  key_name = "tf_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = data.aws_ami.windows.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.tf_key.key_name
  security_groups = ["${aws_security_group.pubsg.id}"]
  associate_public_ip_address = true
  
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "asg"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  vpc_zone_identifier = [aws_subnet.ec2subnet.id]

  lifecycle {
    create_before_destroy = true
  }
}

#DB Instance
resource "aws_db_subnet_group" "dbsubgrp" {
  name       = "dbsubgrp"
  subnet_ids = [aws_subnet.rdssubnet.id, aws_subnet.rdssubnet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "rds_db" {
  identifier            = "mysql-db-01"  
  allocated_storage     = 5
  availability_zone     = aws_subnet.rdssubnet.availability_zone
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


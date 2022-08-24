data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "ec2subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "ec2 public subnet"
  }
}
resource "aws_subnet" "ec2subnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "ec2 public subnet2"
  }
}

resource "aws_subnet" "rdssubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "RDS private subnet"
  }
}

resource "aws_subnet" "rdssubnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "RDS private subnet2"
  }
}
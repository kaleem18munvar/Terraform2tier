resource "aws_internet_gateway" "tigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_nat_gateway" "tnat" {
  allocation_id = aws_eip.teip.id
  subnet_id     = aws_subnet.ec2subnet.id

  tags = {
    Name = "NAT Gateway"
  }
  
}

resource "aws_eip" "teip" {
  vpc      = true
}
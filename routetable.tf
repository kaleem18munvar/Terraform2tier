resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tigw.id
  }


  tags = {
    Name = "Public Routetable"
  }
}

resource "aws_route_table_association" "pubrtass" {
  subnet_id      = aws_subnet.ec2subnet.id
  route_table_id = aws_route_table.pubrt.id
}

resource "aws_route_table" "prirt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tnat.id
  }


  tags = {
    Name = "Private Routetable"
  }
}

resource "aws_route_table_association" "prirtass" {
  subnet_id      = aws_subnet.rdssubnet.id
  route_table_id = aws_route_table.prirt.id
}
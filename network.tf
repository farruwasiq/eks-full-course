resource "aws_internet_gateway" "dev_igw" {
  vpc_id = local.vpc_id
  tags = {
    name = "dev-igw"
  }

}
resource "aws_route_table" "dev_public_rt" {
  vpc_id = local.vpc_id
  route {
    cidr_block = "0.0.0.0/0"                     //since it is public subnet we are routing traffic to everywhere
    gateway_id = aws_internet_gateway.dev_igw.id //route table uses this igw to reach internet

  }
  tags = {
    name = "dev-public-rt"
  }
}
resource "aws_route_table_association" "dev_public_subnet_1a_rt" {
  subnet_id      = aws_subnet.dev_subnet_public_1a.id
  route_table_id = aws_route_table.dev_public_rt.id
}
resource "aws_route_table" "dev_private_rt" {
  vpc_id = local.vpc_id
  #cidr="10.212.210.64/27"
  /*route {
    cidr_block = "0.0.0.0/0"                     //since it is public subnet we are routing traffic to everywhere
    gateway_id = aws_internet_gateway.dev-igw.id //route table uses this igw to reach internet

  }*/
  tags = {
    name = "dev-private-rt"
  }
}
resource "aws_route_table_association" "dev_private_subnet_1a_rt" {
  subnet_id      = aws_subnet.dev_subnet_private_1a.id
  route_table_id = aws_route_table.dev_private_rt.id
}
resource "aws_eip" "nat"{
  vpc=true


}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.dev_subnet_public_1a.id
  depends_on = [ aws_internet_gateway.dev_igw]
  
}
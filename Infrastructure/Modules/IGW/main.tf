# ------- Internet Gateway -------
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc
  tags = {
    Name = "igw_${var.name}"
  }
}

# ------- Create Default Route Public Table -------
resource "aws_default_route_table" "rt_public" {
  default_route_table_id = var.default_route_table

  # ------- Internet Route -------
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt_${var.name}"
  }
}

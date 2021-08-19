# ------- Public Subnets -------
resource "aws_subnet" "public_subnets" {
  count                   = 1
  availability_zone       = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 7, count.index + 1)
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_${count.index}_${var.name}"
  }
}

# ------- Internet Gateway -------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name = "igw_${var.name}"
  }
}

# ------- Create Default Route Public Table -------
resource "aws_default_route_table" "rt_public" {
  default_route_table_id = aws_vpc.aws_vpc.default_route_table_id

  # ------- Internet Route -------
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt_${var.name}"
  }
}
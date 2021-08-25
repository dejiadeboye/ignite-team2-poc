# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*==================================================
      AWS Networking for the whole solution
===================================================*/

# ------- VPC Creation -------
resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.cidr[0]
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc_${var.name}"
  }
}

# ------- Get Region Available Zones -------
data "aws_availability_zones" "az_availables" {
  state = "available"
}

# ------- Subnets Creation -------

# ------- Public Subnets -------
resource "aws_subnet" "public_subnets" {
  count                   = var.pub_count
  availability_zone       = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 7, count.index + 1)
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_${count.index}_${var.name}"
  }
}

# ------- Private Subnets -------
resource "aws_subnet" "private_subnets" {
  count             = var.priv_count
  availability_zone = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 7, count.index + 3)
  tags = {
    Name = "private_subnet_${count.index}_${var.name}"
  }
}

# ------- Public Subnets Association -------
resource "aws_route_table_association" "rt_assoc_pub_subnets" {
  count          = var.pub_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_vpc.aws_vpc.main_route_table_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "transit_gateway" {
  subnet_ids         = [aws_subnet.private_subnets[0].id]
  transit_gateway_id = var.transitid
  vpc_id             = aws_vpc.aws_vpc.id
  tags = {
    Name = "tgw_${var.name}"
  }
}
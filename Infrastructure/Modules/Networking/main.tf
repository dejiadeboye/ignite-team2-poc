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

# ------- Private Subnets -------
resource "aws_subnet" "private_subnets" {
  count             = 2
  availability_zone = data.aws_availability_zones.az_availables.names[count.index]
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.aws_vpc.cidr_block, 7, count.index + 3)
  tags = {
    Name = "private_subnet_${count.index}_${var.name}"
  }
}
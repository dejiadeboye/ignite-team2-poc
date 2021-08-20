# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "aws_vpc" {
  value = aws_vpc.aws_vpc.id
}

output "aws_rt" {
  value = aws_vpc.aws_vpc.default_route_table_id
}


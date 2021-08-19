# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "aws_vpc" {
  value = aws_vpc.aws_vpc.id
}


output "private_subnets" {
  value = [aws_subnet.private_subnets_client[0].id, aws_subnet.private_subnets_client[1].id]
}

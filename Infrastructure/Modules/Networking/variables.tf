# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "name" {
  description = "Provided name used for name concatenation of resources"
  type        = string
}

variable "cidr" {
  description = "CIDR block"
  type        = list(any)
}

variable "pub_count" {
  description = "Number of public subnets to create (independent from type)"
  type        = number
}

variable "priv_count" {
  description = "Number of subnets to create (independent from type)"
  type        = number
}
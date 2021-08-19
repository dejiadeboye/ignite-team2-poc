# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*===========================
          Root file
============================*/

# ------- Providers -------
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  default_tags {
    tags = {
      Created_by = "Terraform"
      Project    = "Ignite_team2_poc"
    }
  }
}

# ------- Random numbers intended to be used as unique identifiers for resources -------
resource "random_id" "RANDOM_ID" {
  byte_length = "2"
}

# ------- Account ID -------
data "aws_caller_identity" "id_current_account" {}

# ------- Networking -------
module "networking1" {
  source = "./Modules/Networking"
  cidr   = ["10.120.0.0/16"]
  name   = "Production"
}

module "networking2" {
  source = "./Modules/Networking"
  cidr   = ["10.121.0.0/16"]
  name   = "Staging"
}

module "networking3" {
  source = "./Modules/Networking"
  cidr   = ["10.122.0.0/16"]
  name   = "Development"
}

module "networking5" {
  source = "./Modules/Networking"
  cidr   = ["10.123.0.0/16"]
  name   = "SharedServices"
}


# ------- Transit Gateway -------
resource "aws_ec2_transit_gateway" "tgw" {
  description = "transit gateway"
  tags = {
    Name = "tgw_${var.name}"
  }
 
}


# ------- Transit Gateway route table -------

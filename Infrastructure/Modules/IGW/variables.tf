variable "vpc" {
  description = "VPC ID for the Target Group"
  type        = string
  default     = ""
}

variable "name" {
  description = "A name for the target group or ALB"
  type        = string
}

variable "default_route_table" {
  description = "Default Route Table ID for the Target Group"
  type        = string
  default     = ""
}

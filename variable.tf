variable "region" {
  description = "Region to Deploy VPC"
  type        = string
  default     = "us-east-1"
}

variable "cidr" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ami" {
  description = "The AMI ID of the instance"
  type        = string
  default     = "ami-0aa7d40eeae50c9a9"
}

variable "instance" {
  description = "The Instance type of EC2"
  type        = string
  default     = "t2.micro"
}

variable "vpc" {
  description = "The Default VPC of EC2"
  type        = string
  default     = "vpc-00098c45afb96b6f8"
}

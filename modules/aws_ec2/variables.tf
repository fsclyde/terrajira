
variable "name" {
  default = "jenkins"
}

variable "aws_default_vpc" {
  default =  "vpc-6ffa9e07"
}

variable "keyname" {
  default = "secops-19062018"
}

variable "subnet_id" {
  default =  "subnet-7ede0a04"
}

variable "aim" {
  default = "ami-2a0f324f"
}

variable "S3_BUCKET" {
  default = "terrajira-secterraform"
}
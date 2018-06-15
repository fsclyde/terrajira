
// AWS variables
variable "identifier" {
  default = "jirards"
}

variable "engine" {
  default = "postgres"
}

variable "engine_version" {
  default = "9.6.6"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "allocated_storage" {
  default = 5
}

variable "name" {
  default = "jirards"
}

variable "port" {
  default = 5432
}

variable "snapshot_identifier" {
  default = "jirasnap"
}

variable "vpc_security_group_ids" {
  default = "sg-0752f4c6f075a0a5c"
}

variable "publicly_accessible" {
  default = true
}

variable "aws_subnets_ids" {
  default = ["subnet-7ede0a04", "subnet-6719850f", "subnet-58b3b415"]
}

variable "aws_default_vpc" {
  default =  "vpc-6ffa9e07"
}

variable "ingress_ips" {
  default = ["198.72.117.8/32"]
}

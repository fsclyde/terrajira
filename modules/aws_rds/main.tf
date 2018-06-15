// AWS
variable "username" {}
variable "password" {}

// AWS Security group
module "postgresql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/postgresql"
  source = "../../terrajira"

  name        = "${var.name}-db"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = "${var.aws_default_vpc}"

  // SC IP address and Google Cloud Compute
  ingress_cidr_blocks      = "${var.ingress_ips}"

}

// AWS RDS
module "aws_rds" {
  source = "terraform-aws-modules/rds/aws"

  //count = "${var.gg_ip != "" ? 1 : 0}"

  identifier = "${var.identifier}"

  engine            = "${var.engine}"
  engine_version    = "${var.engine_version}"
  instance_class    = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"

  name                                = "${var.name}"
  username                            = "${var.username}"
  password                            = "${var.password}"
  port     = "${var.port}"


  # Snapshot name upon DB deletion
  final_snapshot_identifier = "demodb"

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # DB subnet group
  subnet_ids = "${var.aws_subnets_ids}"

  # DB parameter group
  family = "postgres9.6"


//  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  // Add the security group previously created
  vpc_security_group_ids = ["${module.postgresql_security_group.this_security_group_id}"]


  publicly_accessible = "${var.publicly_accessible}"

   tags = {
    Owner       = "secops"
    Environment = "build"
  }

}


// AWS Security group
module "jenkins_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.name}-sg"
  description = "Security group for user-service jenkins web access"
  vpc_id      = "${var.aws_default_vpc}"

  ingress_rules            = ["http-80-tcp"]
  //egress_rules              = ["-1"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  ingress_cidr_blocks = ["0.0.0.0/0"]
 // egress_cidr_blocks  = ["0.0.0.0/0"]
}

// AWS Ec2
module "aws_ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"


  name           = "${var.name}-instance"
  instance_count = 5
  
  ami                    = "${var.aim}"
  instance_type          = "t2.micro"
  key_name               = "${var.keyname}"
  monitoring             = false
  vpc_security_group_ids = ["${module.jenkins_security_group.this_security_group_id}"]
  subnet_id              = "${var.subnet_id}"

  user_data = "${file("modules/aws_ec2/jenkins/userdata.sh")}"

   tags = {
    Owner       = "secops"
    Environment = "build"
  }

}

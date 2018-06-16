
// AWS Security group
module "jenkins_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.name}-sg"
  description = "Security group for user-service jenkins web access"
  vpc_id      = "${var.aws_default_vpc}"

  ingress_rules            = ["http-80-tcp","ssh-tcp"]

  egress_rules              = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}

// Need to change this with the location of your public key
//resource "aws_key_pair" "terraform_ec2_key" {
//  key_name = "secdevops-20062018"
//  key_name = "terraform_ec2_key"
//  public_key = "${file("~/.ssh/id_rsa.pub")}"
//}


// AWS Ec2
module "aws_ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"


  name           = "${var.name}-instance"
  instance_count = 1
  
  ami                    = "${var.aim}"
  instance_type          = "t2.micro"
//  key_name               = "terraform_ec2_key"
  key_name               = "secdevops-20062018"
  monitoring             = false
  vpc_security_group_ids = ["${module.jenkins_security_group.this_security_group_id}"]
  subnet_id              = "${var.subnet_id}"

  associate_public_ip_address = true

  user_data = "${file("modules/aws_ec2/jenkins/userdata.sh")}"

   tags = {
    Owner       = "secops"
    Environment = "build"
  }

}



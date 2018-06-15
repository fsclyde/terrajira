output "jenkins_public_dns" {
  value = "${module.aws_ec2.public_dns}"
}



// AWS provider
provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "/home/clyde/.aws/credentials"
}

// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("./creds/google_secret.json")}"
  project     = "jirasde"
  region = "${var.region}"
}

// Google Cloud
module "google_compute" {
  source = "./modules/google_compute"
}

// AWS RDS for jira
variable rds_username {}
variable rds_password {}
module "aws_rds" {
  source = "./modules/aws_rds"
  username = "${var.rds_username}"
  password = "${var.rds_username}"
}

// AWS Ec2 for jenkins
module "aws_ec2" {
  source = "./modules/aws_ec2"
}

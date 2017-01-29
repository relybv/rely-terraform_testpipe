# Configure the openstack provider
#
provider "openstack" {
  user_name  = "${var.user_name}"
  tenant_name = "${var.tenant_name}"
  password  = "${var.password}"
  insecure = true
  auth_url  = "${var.auth_url}"
}

#
# Keypair
#
resource "openstack_compute_keypair_v2" "terraform" {
  name = "SSH keypair for Customer ${var.customer} Environment ${var.environment}"
  region = "${var.region}"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}
#
# AWS resources
#

# Configure the AWS Provider
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "eu-central-1"
}
/*
# Terraform.state stored on AWS S3
resource "terraform_remote_state" "aws" {
    backend = "s3"
    config {
        bucket = "${var.swift_bucket_name}"
        key = "${var.swift_key}"
        region = "${var.swift_region}"
        access_key = "${var.aws_access_key}"
        secret_key = "${var.aws_secret_key}"
    }
}
*/

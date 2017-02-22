variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "us-east-1"
}
resource "aws_key_pair" "urgenaccess" {
key_name = "urgenaccess"
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/yQDcmbanz52HXDboooHG94RSbZUJ1cWZr0RyFUajCp0yP5LTeR+fCzNdSMoMY90RmCsmA3WACFkotfsBbCJP2lXa/RAUWiPK76NaZ3pHiIPM8FKm6pYX0xdc9lWrq4Rk4NRhRaie6PE4iPgYbLTKGalQfJaBWBSPzirOrWHPU8K9yedN1M7JaBVt31oUIR29wLzDyAL8Oo+wWWnBWpFuRmpWtCzEtd6ODsuOQ28udNyVp7w8A4iXiK7QKUGVekPm1igWyc5fOHnizay3mBFQxBcbgCypeE3VGwdGSSF8Pe6D612Bu94DXXSLTGCtVbLTHTdqWoiEI1Sw+GA8EIr9 root@lb1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"
  subnet_id = "subnet-7b5c8820"
  key_name = "${aws_key_pair.urgenaccess.key_name}"

  provisioner "local-exec" {
      command = "sleep 60 && echo ${aws_instance.example.public_ip} > hosts.txt  && ansible-playbook -i hosts.txt --private-key=urgenaccess /etc/ansible/roles/site.yml"
  }
  tags {
      Name = "TerraformTestInstance"
  }
}

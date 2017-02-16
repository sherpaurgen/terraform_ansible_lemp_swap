resource "aws_autoscaling_group" "ASG" {
    availability_zones = ["us-east-1c"]
    name = "ASGurgen"
    max_size = "8"
    min_size = "2"
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 2
    force_delete = true
    launch_configuration = "${aws_launch_configuration.demoLC.name}"
    load_balancers = ["${aws_elb.ELB-Terraform.name}"]
    health_check_type = "ELB"

    tag {
        key = "Name"
        value = "ec2-auto-scale-terraform"
        propagate_at_launch = true
    }
}

resource "aws_launch_configuration" "demoLC" {
    name_prefix = "demoLC"
    image_id = "ami-892fe69f"
    instance_type = "t2.micro"
     security_groups = ["sg-d1223aab"]

    lifecycle {
        create_before_destroy = true
    }

    root_block_device {
        volume_type = "gp2"
        volume_size = "10"
    }
}

resource "aws_elb" "ELB-Terraform" {
name = "ELB-Terraform"
security_groups = ["${aws_security_group.ELB-Terraform-SG.id}"]
  availability_zones = [ "us-east-1b", "us-east-1c"]
   
health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
}

resource "aws_security_group" "ELB-Terraform-SG" {
 name = "terraform-SG"
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

output "elb_dns_name" {
  value = "${aws_elb.ELB-Terraform.dns_name}"
}

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
    load_balancers = ["lb1"]


    tag {
        key = "Name"
        value = "ec2-auto"
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

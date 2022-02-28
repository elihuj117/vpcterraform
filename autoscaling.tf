resource "aws_launch_configuration" "launchconfig" {
  name_prefix = "launchconfig.${var.vpc_name}.${var.domain}"
  image_id = "ami-08bbc835fa43c979b"
  instance_type = "t2.micro"
  key_name = "aws.local"
  security_groups = [aws_security_group.lab_access.id]
  user_data = <<-EOF
              #!/bin/bash
              instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
              echo "Terraform baby!" >> index.html
              echo "<br>" >> index.html
              echo "This refresh brought to you by: $instanceId" >> index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "asg.${var.vpc_name}.${var.domain}"
  launch_configuration = "${aws_launch_configuration.launchconfig.id}"
  min_size = 2
  max_size = 2
  health_check_type = "ELB"
  vpc_zone_identifier = "${data.aws_subnet.publicsubnet.*.id}"
  
  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key = "Name"
    value = "asg"
    propagate_at_launch = true
  } 
}

resource "aws_autoscaling_attachment" "asg-elb" {
  autoscaling_group_name = "${aws_autoscaling_group.asg.id}"
  alb_target_group_arn = "${aws_lb_target_group.asg-elb.arn}"
}

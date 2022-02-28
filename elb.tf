resource "aws_lb" "elb" {
  name = "elb"
  internal = "false"
  load_balancer_type = "application"
  security_groups = [aws_security_group.lab_access.id]
  subnets = "${data.aws_subnet.publicsubnet.*.id}"
}

resource "aws_lb_target_group" "asg-elb" {
  name = "elb-tg"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc01.id

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    protocol = "HTTP"
    port = 8080
  }
}

resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.elb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.asg-elb.arn}"
    type = "forward"
  }
} 

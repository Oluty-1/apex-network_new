resource "aws_lb_target_group" "apexapp_tg" {
  name        = "apexecstg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }

  deregistration_delay = 300

  tags = {
    Name = "apexecstg"
  }
}

resource "aws_lb_target_group" "apexapp_tg" {
  name        = var.TG_NAME
  port        = var.PORT
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
    Name = var.TG_NAME
  }
}

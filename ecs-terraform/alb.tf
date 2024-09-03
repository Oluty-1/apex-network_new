# Application Load Balancer
resource "aws_lb" "apexapp_alb" {
  name               = "apexappelbecs"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.apexapp_sg.id]
  subnets            = data.aws_subnets.default.ids

  tags = {
    Name = "apexappelbecs"
  }
}

# Listener for Application Load Balancer
resource "aws_lb_listener" "apexapp_http_listener" {
  load_balancer_arn = aws_lb.apexapp_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apexapp_tg.arn
  }
}

# Data sources to get default VPC and subnets
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ECS Service
resource "aws_ecs_service" "apexapp_svc" {
  name            = "apexappsvc"
  cluster         = aws_ecs_cluster.apexapp_cluster.id
  task_definition = "apexapptask:${var.task_revision}"
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.default.ids
    security_groups = [aws_security_group.apexapp_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.apexapp_tg.arn
    container_name   = "apexapp"
    container_port   = 3000
  }

  depends_on = [
    aws_lb_listener.apexapp_http_listener
  ]

  tags = {
    Name = "apexappsvc"
  }
}

resource "aws_ecs_task_definition" "apexapptask" {
  family                   = var.TASK_FAMILY
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = var.MEMORY
  task_role_arn            = "arn:aws:iam::302225372317:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::302225372317:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = var.CONTAINER_NAME
      image     = var.DOCKER_IMAGE
      cpu       = 0
      essential = true

      portMappings = [
        {
          name          = "apexapp-3000-tcp"
          containerPort = var.PORT
          hostPort      = var.PORT
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      secrets = [
        {
          name      = "DB_URL"
          valueFrom = var.DB_URL_SECRET
        },
        {
          name      = "PORT"
          valueFrom = var.PORT_SECRET
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/apexapptask"
          "mode"                  = "non-blocking"
          "awslogs-create-group"  = "true"
          "max-buffer-size"       = "25m"
          "awslogs-region"        = var.REGION
          "awslogs-stream-prefix" = "ecs"
        }
      }

      environment    = []
      mountPoints    = []
      volumesFrom    = []
      systemControls = []
    }
  ])

  tags = {
    Name = var.TASK_FAMILY
  }
}

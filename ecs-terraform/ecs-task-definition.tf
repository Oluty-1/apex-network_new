resource "aws_ecs_task_definition" "apexapptask" {
  family                   = "apexapptask"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  task_role_arn            = "arn:aws:iam::302225372317:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::302225372317:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name        = "apexapp"
      image       = "oluty/apexapp:latest"
      cpu         = 0
      essential   = true

      portMappings = [
        {
          name          = "apexapp-3000-tcp"
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      secrets = [
        {
          name      = "DB_URL"
          valueFrom = "arn:aws:secretsmanager:us-east-2:302225372317:secret:ApexSecrets_DB_URL-IYnCpn"
        },
        {
          name      = "PORT"
          valueFrom = "arn:aws:secretsmanager:us-east-2:302225372317:secret:ApexSecrets-tRFSbw"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/apexapptask"
          "mode"                  = "non-blocking"
          "awslogs-create-group"  = "true"
          "max-buffer-size"       = "25m"
          "awslogs-region"        = "us-east-2"
          "awslogs-stream-prefix" = "ecs"
        }
      }

      environment        = []
      mountPoints        = []
      volumesFrom        = []
      systemControls     = []
    }
  ])

  tags = {
    Name = "apexapptask"
  }
}

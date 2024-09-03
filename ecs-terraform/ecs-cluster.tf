# ECS Cluster
resource "aws_ecs_cluster" "apex_cluster" {
  name = "apex"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "apex"
  }
}

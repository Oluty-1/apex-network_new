# ECS Cluster
resource "aws_ecs_cluster" "apex_cluster" {
  name = var.CLUSTER_NAME

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.CLUSTER_NAME
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the AmazonECSTaskExecutionRolePolicy managed policy to the role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Custom policy for accessing Secrets Manager
resource "aws_iam_policy" "ecs_task_secrets_policy" {
  name        = "ecsTaskSecretsPolicy"
  description = "Policy granting ECS tasks permission to access secrets in Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:secretsmanager:us-east-2:302225372317:secret:ApexSecrets_DB_URL-IYnCpn",
          "arn:aws:secretsmanager:us-east-2:302225372317:secret:ApexSecrets-tRFSbw"
        ]
      }
    ]
  })
}

# Attach the custom secrets policy to the ECS Task Execution Role
resource "aws_iam_role_policy_attachment" "ecs_task_secrets_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_secrets_policy.arn
}

variable "REGION" {
  default = "us-east-2"
}

variable "CLUSTER_NAME" {
  default = "apex"
}

variable "MEMORY" {
  default = "2048"
}

variable "PORT" {
  default = "3000"
}

variable "DOCKER_IMAGE" {
  default = "oluty/apexapp:latest"
}

variable "CONTAINER_NAME" {
  default = "apexapp"
}

variable "DB_URL_SECRET" {
  default = "arn:aws:secretsmanager:us-east-2:302225372317:secret:ApexSecrets:DB_URL::"
}

variable "PORT_SECRET" {
  default = "arn:aws:secretsmanager:us-east-2:302225372317:secret:ApexSecrets:PORT::"
}

variable "TASK_FAMILY" {
  default = "apexapptask"
}

variable "SERVICE_NAME" {
  default = "apexappsvc"
}

variable "ALB_NAME" {
  default = "apexappelbecs"
}

variable "TG_NAME" {
  default = "apexecstg"
}

variable "SG_NAME" {
  default = "apexappecs-sg"
}
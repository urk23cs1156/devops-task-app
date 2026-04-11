terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# USER SERVICE
resource "docker_container" "user_service" {
  name  = "user-service"
  image = "devops-task-app-user-service:latest"

  ports {
    internal = 3001
    external = 3001
  }
}

# TASK SERVICE
resource "docker_container" "task_service" {
  name  = "task-service"
  image = "devops-task-app-task-service:latest"

  ports {
    internal = 3002
    external = 3002
  }
}

# GATEWAY
resource "docker_container" "gateway" {
  name  = "gateway"
  image = "devops-task-app-gateway:latest"

  ports {
    internal = 3000
    external = 3000
  }
}
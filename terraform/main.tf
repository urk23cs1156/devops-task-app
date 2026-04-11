terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# ---------------- BUILD DOCKER IMAGES ----------------

resource "null_resource" "build_images" {
  provisioner "local-exec" {
    command = <<EOT
    docker build -t devops-task-app-user-service ../user-service
    docker build -t devops-task-app-task-service ../task-service
    docker build -t devops-task-app-gateway ../gateway
    EOT
  }
}

# ---------------- USER DEPLOYMENT ----------------

resource "kubernetes_deployment" "user" {
  depends_on = [null_resource.build_images]

  metadata {
    name = "user-service"
    labels = { app = "user-service" }
  }

  spec {
    replicas = 1

    selector {
      match_labels = { app = "user-service" }
    }

    template {
      metadata {
        labels = { app = "user-service" }
      }

      spec {
        container {
          name  = "user-service"
          image = "devops-task-app-user-service:latest"
          image_pull_policy = "Never"

          port {
            container_port = 3001
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "user" {
  metadata {
    name = "user-service"
  }

  spec {
    selector = { app = "user-service" }

    port {
      port        = 3001
      target_port = 3001
      node_port   = 30011
    }

    type = "NodePort"
  }
}

# ---------------- TASK DEPLOYMENT ----------------

resource "kubernetes_deployment" "task" {
  depends_on = [null_resource.build_images]

  metadata {
    name = "task-service"
    labels = { app = "task-service" }
  }

  spec {
    replicas = 1

    selector {
      match_labels = { app = "task-service" }
    }

    template {
      metadata {
        labels = { app = "task-service" }
      }

      spec {
        container {
          name  = "task-service"
          image = "devops-task-app-task-service:latest"
          image_pull_policy = "Never"

          port {
            container_port = 3002
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "task" {
  metadata {
    name = "task-service"
  }

  spec {
    selector = { app = "task-service" }

    port {
      port        = 3002
      target_port = 3002
      node_port   = 30012
    }

    type = "NodePort"
  }
}

# ---------------- GATEWAY DEPLOYMENT ----------------

resource "kubernetes_deployment" "gateway" {
  depends_on = [null_resource.build_images]

  metadata {
    name = "gateway"
    labels = { app = "gateway" }
  }

  spec {
    replicas = 1

    selector {
      match_labels = { app = "gateway" }
    }

    template {
      metadata {
        labels = { app = "gateway" }
      }

      spec {
        container {
          name  = "gateway"
          image = "devops-task-app-gateway:latest"
          image_pull_policy = "Never"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "gateway" {
  metadata {
    name = "gateway"
  }

  spec {
    selector = { app = "gateway" }

    port {
      port        = 3000
      target_port = 3000
      node_port   = 30007
    }

    type = "NodePort"
  }
}
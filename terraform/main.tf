# Khai báo sử dụng Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Tạo Network chung để các service gọi nhau
resource "docker_network" "private_network" {
  name = "go_modular_network"
}

# 1. Tạo PostgreSQL
resource "docker_container" "postgres" {
  name  = "postgres_db"
  image = "postgres:15-alpine"
  networks_adv {
    name = docker_network.private_network.name
  }
  env = [
    "POSTGRES_USER=user",
    "POSTGRES_PASSWORD=password",
    "POSTGRES_DB=modular_db"
  ]
  ports {
    internal = 5432
    external = 5432
  }
}

# 2. Tạo RabbitMQ
resource "docker_container" "rabbitmq" {
  name  = "rabbitmq_broker"
  image = "rabbitmq:3-management"
  networks_adv {
    name = docker_network.private_network.name
  }
  ports {
    internal = 5672
    external = 5672
  }
  ports {
    internal = 15672
    external = 15672 # Management UI
  }
}
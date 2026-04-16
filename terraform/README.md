# Terraform 101: Quản lý Hạ tầng bằng Mã nguồn (IaC)

## 1. Terraform là gì?
Terraform là công cụ **Infrastructure as Code (IaC)** giúp định nghĩa hạ tầng bằng ngôn ngữ khai báo (HCL). 
Thay vì click tay trên giao diện, bạn viết code để tạo Server, Database, Queue...

### Tại sao nên dùng Terraform?
* **Đồng nhất:** Đảm bảo môi trường Local, Dev và Prod giống hệt nhau.
* **Tốc độ:** Dựng toàn bộ hệ thống (DB, Message Queue, Cache) chỉ với 1 câu lệnh.
* **Lịch sử:** Quản lý thay đổi hạ tầng thông qua Git tương tự như code ứng dụng.

---

## 2. Quy trình làm việc (Workflow)
Mọi thao tác với Terraform đều xoay quanh 4 bước:

1.  `terraform init`: Khởi tạo project và tải các Provider cần thiết (Docker, AWS...).
2.  `terraform plan`: Kiểm tra xem Terraform sẽ thay đổi những gì (Review trước khi làm).
3.  `terraform apply`: Thực thi việc tạo/thay đổi hạ tầng.
4.  `terraform destroy`: Hủy toàn bộ hạ tầng đã tạo để dọn dẹp tài nguyên.

---

## 3. Demo: Dựng môi trường cho Backend Go
Dưới đây là ví dụ file `main.tf` để dựng nhanh **PostgreSQL** và **RabbitMQ** cho dự án modular của bạn.

```hcl
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
```

---

## 4. Các khái niệm cốt lõi cần nhớ
* **Provider:** Các plugin để Terraform hiểu cách nói chuyện với AWS, Docker, Azure...
* **Resource:** Một thành phần cụ thể trong hạ tầng (Ví dụ: một cái Container, một cái VPC).
* **State (`.tfstate`):** File ghi nhớ trạng thái hiện tại của hạ tầng. **Không xóa hoặc sửa file này bằng tay.**
* **Variable:** Dùng để biến các thông số (như Password, Port) thành tham số truyền vào, tránh hard-code.

---

## 5. Lưu ý cho Developer
* Luôn chạy `terraform plan` trước khi `apply` để tránh "bay màu" database quan trọng.
* Nên chia nhỏ code Terraform theo từng Module (ví dụ: module db, module network) nếu hệ thống lớn dần.
* Tài liệu tra cứu chính: [Terraform Registry](https://registry.terraform.io/)

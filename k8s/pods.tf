resource "kubernetes_replication_controller" "backend" {
  metadata {
    name = "minutebeer-backend"
  }

  spec {
    replicas = 1

    selector = {
      app  = "minutebeer"
      tier = "backend"
    }

    template {
      container {
        image = "616711703503.dkr.ecr.eu-central-1.amazonaws.com/minutebeer:${var.github-sha}"
        name  = "minutebeer-backend"

        env {
          name  = "GET_HOSTS_FROM"
          value = "dns"
        }

        env {
          name  = "DB_HOST"
          value = "${var.database_host}"
        }

        env {
          name  = "DB_USER"
          value = "${var.database_user}"
        }

        env {
          name  = "DB_NAME"
          value = "karhu"
        }

        env {
          name  = "DB_PASSWORD"
          value = "${var.database_password}"
        }

        env {
          name  = "SERVER_PORT"
          value = "3000"
        }

        env {
          name  = "SOCKET_PORT"
          value = "3001"
        }

        env {
          name  = "JWT_SECRET"
          value = "${var.jwt-secret}"
        }

        resources {
          requests {
            cpu    = "100m"
            memory = "100Mi"
          }
        }
      }
    }
  }
}

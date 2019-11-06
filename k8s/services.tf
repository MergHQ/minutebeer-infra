resource "kubernetes_service" "backend" {
  metadata {
    name = "minutebeer-backend"
  }

  spec {
    port {
      port = 3000
    }
  }
}

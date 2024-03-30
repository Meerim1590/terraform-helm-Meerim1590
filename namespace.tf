resource "kubernetes_namespace" "example" {
  metadata {
    name = "nginx-app"
  }
}

resource "kubernetes_resource_quota" "example" {
  metadata {
    name = "podlimit"
    namespace = "nginx-app"
  }
  spec {
    hard = {
      pods = 10
    }
    scopes = ["BestEffort"]
  }
}

resource "kubernetes_limit_range" "example" {
  metadata {
    name = "nginx-app-limit"
    namespace = "nginx-app"
  }
  spec {
    limit {
      type = "Pod"
      max = {
        cpu    = "200m"
        memory = "1024Mi"
      }
    }
    limit {
      type = "PersistentVolumeClaim"
      min = {
        storage = "24M"
      }
    }
    limit {
      type = "Container"
      default = {
        cpu    = "50m"
        memory = "24Mi"
      }
    }
  }
}
resource "kubernetes_service" "redis-master" {
  metadata {
    name = "kill-my-cpu-master"

    labels {
      app  = "kill-my-cpu"
      role = "master"
      tier = "backend"
    }
  }

  spec {
    selector {
      app  = "kill-my-cpu"
      role = "master"
      tier = "backend"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_service" "kill-my-cpu-slave" {
  metadata {
    name = "kill-my-cpu-slave"

    labels {
      app  = "kill-my-cpu"
      role = "slave"
      tier = "backend"
    }
  }

  spec {
    selector {
      app  = "kill-my-cpu"
      role = "slave"
      tier = "backend"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}

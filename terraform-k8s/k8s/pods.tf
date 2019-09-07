resource "kubernetes_replication_controller" "kill-my-cpu-master" {
  metadata {
    name = "kill-my-cpu"

    labels {
      app  = "kill-my-cpu"
      role = "master"
      tier = "backend"
    }
  }

  spec {
    replicas = 1

    selector = {
      app  = "kill-my-cpu"
      role = "master"
      tier = "backend"
    }

    template {
      container {
        image = "matix26/kill_cpu_app:killapp"
        name  = "master"

        port {
          container_port = 80
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

resource "kubernetes_replication_controller" "kill-my-cpu-slave" {
  metadata {
    name = "kill-my-cpu-slave"

    labels {
      app  = "kill-my-cpu"
      role = "slave"
      tier = "backend"
    }
  }

  spec {
    replicas = 2

    selector = {
      app  = "kill-my-cpu"
      role = "slave"
      tier = "backend"
    }

    template {
      container {
        image = "matix26/kill_cpu_app:killapp"
        name  = "slave"

        port {
          container_port = 80
        }

        env {
          name  = "GET_HOSTS_FROM"
          value = "dns"
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

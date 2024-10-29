resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id  = yandex_kubernetes_cluster.k8s-zonal.id
  name        = "name"
  description = "description"
  version     = "1.29"

  labels = {
    "key" = "value"
  }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = false
      subnet_ids = ["${yandex_vpc_subnet.mysubnet.id}"]
      security_group_ids = [
        yandex_vpc_security_group.k8s-main-sg.id,
        yandex_vpc_security_group.k8s-nodes-ssh-access.id,
        yandex_vpc_security_group.k8s-public-services.id
      ]
    }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}


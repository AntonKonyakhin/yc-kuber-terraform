resource "yandex_compute_instance" "vm-1" {
  name = "wireguard"

  resources {
    cores  = 2
    memory = 2
    core_fraction = var.fract_cpu
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.mysubnet.id
    nat       = true
  }

  scheduling_policy {
  preemptible = var.interruptable
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


output "wireguard_external_ip" {
  value = "${resource.yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
}

output "wireguard_internal_ip" {
  value = "${resource.yandex_compute_instance.vm-1.network_interface.0.ip_address}"
}

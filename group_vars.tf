resource "local_file" "group_vars" {
# получаем имена сайтов, путем отрезания последней точки с конца.connection 
# иначе name_server в конфиге nginx получается с точкой и при вводе адреса в браузер попадаем на страницу по умолчанию  
  
  content = <<-DOC
  ---
  custom_var: all
  letsencrypt_email: ${var.email}
  squid_port: 3128
  ip_wireguard_ext: ${resource.yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}
  ip_wireguard_int: ${resource.yandex_compute_instance.vm-1.network_interface.0.ip_address}
  DOC

  filename = "ansible/group_vars/all.yml"
    depends_on = [yandex_compute_instance.vm-1,
  ]

}

resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 120"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "ansible_script" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ansible/inventory/prod.yml ansible/site.yaml"
  }

  depends_on = [
    null_resource.wait
  ]
}

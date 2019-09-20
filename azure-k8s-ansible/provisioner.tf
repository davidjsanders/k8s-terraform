# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      main.tf
# Environments:   all
# Purpose:        Terraform main.tf module.
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

resource "null_resource" "provisioner" {
  triggers = {
    vm_jumpbox_id      = azurerm_virtual_machine.vm-jumpbox.id
    vm_k8s_master_1_id = azurerm_virtual_machine.vm-master.id
    vm_k8s_worker_1_id = azurerm_virtual_machine.vm-workers[0].id
    vm_k8s_worker_2_id = azurerm_virtual_machine.vm-workers[1].id
  }

  connection {
    host        = azurerm_public_ip.k8s-pip-jump.ip_address
    type        = "ssh"
    user        = var.vm-adminuser
    private_key = file(local.l_pk_file)
  }

  provisioner "file" {
    source      = var.private-key
    destination = "/home/${var.vm-adminuser}/.ssh/azure_pk"
  }

  provisioner "file" {
    source      = "${var.private-key}.pub"
    destination = "/home/${var.vm-adminuser}/.ssh/azure_pk.pub"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/home/${var.vm-adminuser}/bootstrap.sh"
  }

  provisioner "file" {
    source      = "ansible/k8s-playbook"
    destination = "/home/${var.vm-adminuser}/playbooks"
  }

  provisioner "file" {
    content     = data.template_file.template-master-vars-yml.rendered
    destination = "/home/${var.vm-adminuser}/playbooks/k8s_master/vars/main.yml"
  }

  provisioner "file" {
    content     = data.template_file.template-workers-vars-yml.rendered
    destination = "/home/${var.vm-adminuser}/playbooks/k8s_label_nodes/vars/main.yml"
  }

  provisioner "file" {
    content     = data.template_file.template-nginx-vars.rendered
    destination = "/home/${var.vm-adminuser}/playbooks/k8s_nginx_ingress_controller/vars/main.yml"
  }

  provisioner "file" {
    content     = data.template_file.template-nexus-vars.rendered
    destination = "/home/${var.vm-adminuser}/playbooks/k8s_nexus_oss/vars/main.yml"
  }

  provisioner "file" {
    content     = data.template_file.template-letsencrypt.rendered
    destination = "/home/${var.vm-adminuser}/playbooks/k8s_letsencrypt/vars/main.yml"
  }

  provisioner "file" {
    content     = data.template_file.template-hosts-file.rendered
    destination = "/home/${var.vm-adminuser}/hosts"
  }

  provisioner "file" {
    content     = data.template_file.template-ansible-inventory.rendered
    destination = "/home/${var.vm-adminuser}/inventory"
  }

  provisioner "file" {
    content     = data.template_file.template-ssh-config.rendered
    destination = "/home/${var.vm-adminuser}/.ssh/config"
  }

  provisioner "local-exec" {
    command = "echo 'DDNS: ${azurerm_public_ip.k8s-pip-jump.ip_address} --> *.${var.jumpbox_domain_name}'; curl -X POST 'https://${var.jumpbox_username}:${var.jumpbox_password}@domains.google.com/nic/update?hostname=${var.jumpbox_domain_name}&myip=${azurerm_public_ip.k8s-pip-jump.ip_address}&offline=no'; echo"
  }

  provisioner "local-exec" {
    command = "echo 'DDNS: ${azurerm_public_ip.k8s-pip-lb.ip_address} --> *.${var.ddns_domain_name}'; curl -X POST 'https://${var.wild_username}:${var.wild_password}@domains.google.com/nic/update?hostname=*${var.ddns_domain_name}&myip=${azurerm_public_ip.k8s-pip-lb.ip_address}&offline=no'; echo"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/bootstrap.sh",
      "~/bootstrap.sh",
      "echo 'Done.'",
    ]
  }

  provisioner "local-exec" {
    command = "echo 'DDNS: ${azurerm_public_ip.k8s-pip-lb.ip_address} /-> *.${var.ddns_domain_name}'; curl -X POST 'https://${var.wild_username}:${var.wild_password}@domains.google.com/nic/update?hostname=*${var.ddns_domain_name}&myip=0.0.0.0&offline=no'; echo"
    when    = destroy
  }

  provisioner "local-exec" {
    command = "echo 'DDNS: ${azurerm_public_ip.k8s-pip-jump.ip_address} /-> *.${var.jumpbox_domain_name}'; curl -X POST 'https://${var.jumpbox_username}:${var.jumpbox_password}@domains.google.com/nic/update?hostname=${var.jumpbox_domain_name}&myip=0.0.0.0&offline=no'; echo"
    when    = destroy
  }
}


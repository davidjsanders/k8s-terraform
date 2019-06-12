# data "azurerm_resource_group" "vnet-resource-group" {
#   name = "${var.vnet-resource-group}"
# }

# data "azurerm_virtual_network" "vnet" {
#   name                 = "${var.vnet-name}"
#   resource_group_name  = "${var.vnet-resource-group}"
# }

data "template_file" "master-sh" {
  template = "${file("templates/master.sh")}"

  vars {
    admin="${var.vm-adminuser}"
  }
}

data "template_file" "worker-sh" {
  template = "${file("templates/worker.sh")}"

  vars {
    admin="${var.vm-adminuser}"
  }
}

data "template_file" "scp-commands-sh" {
  template = "${file("templates/scp-commands.sh")}"

  vars {
    copy_targets="${local.l-pnic-master-1-ip} ${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
  }
}

data "template_file" "ssh-commands-sh" {
  template = "${file("templates/ssh-commands.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    masters="${local.l-pnic-master-1-ip}"
    workers="${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
  }
}

data "template_file" "ssh-config" {
  template = "${file("templates/config")}"

  vars {
  }
}

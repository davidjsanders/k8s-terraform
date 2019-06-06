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
  }
}

data "template_file" "worker-sh" {
  template = "${file("templates/worker.sh")}"

  vars {
  }
}

data "template_file" "ssh-config" {
  template = "${file("templates/config")}"

  vars {
  }
}

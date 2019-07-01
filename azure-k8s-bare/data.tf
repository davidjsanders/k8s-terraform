# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      data.tf
# Environments:   all
# Purpose:        Module to populate data items with content from Azure
#                 and to interpolate variables.
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

#
# DEPRECATED BLOCK STARTS
#
# data "azurerm_resource_group" "vnet-resource-group" {
#   name = "${var.vnet-resource-group}"
# }

# data "azurerm_virtual_network" "vnet" {
#   name                 = "${var.vnet-name}"
#   resource_group_name  = "${var.vnet-resource-group}"
# }
#
# DEPRECATED BLOCK ENDS
#

# Get the managed disk being used to provide persistent storage
# for the k8s cluster.
data "azurerm_managed_disk" "datasourcemd" {
  name                = "${var.disk-master-name}"
  resource_group_name = "${var.disk-rg-name}"
}

# Compute and interpolate the variables required for master.sh
data "template_file" "master-sh" {
  template = "${file("templates/master.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    workers="${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
  }
}

# Compute and interpolate the variables required for worker.sh
data "template_file" "worker-sh" {
  template = "${file("templates/worker.sh")}"

  vars {
    admin="${var.vm-adminuser}"
  }
}

# Compute and interpolate the variables required for the hosts file
data "template_file" "hosts" {
  template = "${file("templates/hosts")}"

  vars {
    master="${local.l-pnic-master-1-ip}"
    worker1="${local.l-nic-worker-1-ip}"
    worker2="${local.l-nic-worker-2-ip}"
    jumpbox="${local.l-pnic-jumpbox-1-ip}"
  }
}

# Compute and interpolate the variables required for scp-commands.sh
data "template_file" "scp-commands-sh" {
  template = "${file("templates/scp-commands.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    copy_targets="${local.l-pnic-master-1-ip} ${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
  }
}

# Compute and interpolate the variables required for ssh-commands.sh
data "template_file" "ssh-commands-sh" {
  template = "${file("templates/ssh-commands.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    masters="${local.l-pnic-master-1-ip}"
    workers="${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
  }
}

# Compute and interpolate the variables required for the ssh config
# file
data "template_file" "ssh-config" {
  template = "${file("templates/config")}"

  vars {
  }
}

# Compute and interpolate the variables required for setup-nfs-server.sh
data "template_file" "setup-nfs-server-sh" {
  template = "${file("templates/k8s-scripts/setup-nfs-server.sh")}"

  vars {
    workers="${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
    masters="${local.l-pnic-master-1-ip}"
  }
}

# Compute and interpolate the variables required for 5-ingress.yaml
# in the Traefik app
data "template_file" "ingress-yaml" {
  template = "${file("templates/traefik/5-ingress.yaml")}"

  vars {
    lbip="${module.pip-elb.ip_address}"
  }
}

# Compute and interpolate the variables required for 
# 8-nginx-ingress.yaml in the Traefik app
data "template_file" "nginx-ingress-yaml" {
  template = "${file("templates/traefik/8-nginx-ingress.yaml")}"

  vars {
    lbip="${module.pip-elb.ip_address}"
  }
}

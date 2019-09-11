# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      nic-jumpox.tf
# Environments:   all
# Purpose:        Module to define the Azure network interface card
#                 (nic) for the VM workers.
#
# Created on:     10 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 10 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
locals {
  l_nic_worker_ips = {
    "0" = "${var.worker-static-ip-1}"
    "1" = "${var.worker-static-ip-2}"
  }
}

resource "azurerm_network_interface" "k8s-nic-workers" {
  count = "${length(local.l_nic_worker_ips)}"

  location            = "${var.location}"
  name                = "${format("NIC-WORKER-%02d-%s-%s%s", count.index + 1, var.target, var.environ, local.l-random)}"
  resource_group_name = "${azurerm_resource_group.k8s-rg.name}"

  ip_configuration {
    name                          = "${format("NIC-WORKER-%02d-IPCONFIG-%s-%s%s", count.index + 1, var.target, var.environ, local.l-random)}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "${replace(lookup(local.l_nic_worker_ips, count.index), "dc-prefix", var.dc-prefix)}"
    subnet_id                     = "${azurerm_subnet.k8s-subnet-worker.id}"
  }

  tags = "${var.tags}"
}


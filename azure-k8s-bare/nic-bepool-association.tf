# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      worker-nsg-association.tf
# Environments:   all
# Purpose:        Module to associate the worker subnet to the
#                 Network Security Group.
#
# Created on:     05 August 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 05 Aug 2019  | David Sanders               | First release.

locals {
  l-config-name-worker-1 = "${format("%s-ip-config", local.l-nic-worker-1)}"
  l-config-name-worker-2 = "${format("%s-ip-config", local.l-nic-worker-2)}"
}

resource "azurerm_network_interface_backend_address_pool_association" "worker-1-nic-bepool" {
    network_interface_id = "${module.nic-worker-1.id}"
    backend_address_pool_id = "${module.lb-workers-bepool.id}"
    ip_configuration_name = "${local.l-config-name-worker-1}"
}

resource "azurerm_network_interface_backend_address_pool_association" "worker-2-nic-bepool" {
    network_interface_id = "${module.nic-worker-2.id}"
    backend_address_pool_id = "${module.lb-workers-bepool.id}"
    ip_configuration_name = "${local.l-config-name-worker-2}"
}

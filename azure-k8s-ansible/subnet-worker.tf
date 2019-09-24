# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      subnet-worker.tf
# Environments:   all
# Purpose:        Module to define the Azure sub-network used by the
#                 worker.
#
# Created on:     08 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 08 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

resource "azurerm_subnet" "k8s-subnet-worker" {
  # Assumes the first address space is used for the worker subnet
  address_prefix = cidrsubnet(
    azurerm_virtual_network.k8s-vnet.address_space[0], 
    8, 
    32
  )
  name = format(
    "SNET-%s-%s-%s-%s%s",
    var.vnet-name,
    var.subnet-wrk-name,
    var.target,
    var.environ,
    local.l-random,
  )
  resource_group_name       = azurerm_resource_group.k8s-rg.name
  virtual_network_name      = azurerm_virtual_network.k8s-vnet.name
  network_security_group_id = azurerm_network_security_group.k8s-vnet-nsg.id
}


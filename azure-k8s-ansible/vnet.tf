# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      vnet.tf
# Environments:   all
# Purpose:        Module to define the Azure virtual network used by
#                 master, minions and load balancers.
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

resource "azurerm_virtual_network" "k8s-vnet" {
  address_space       = ["${var.vnet-cidr}"]
  location            = "${var.location}"
  name                = "${upper(format("VNET-%s-%s-%s%s", var.vnet-name, var.target, var.environ, local.l-random))}"
  resource_group_name = "${azurerm_resource_group.k8s-rg.name}"

  tags = "${var.tags}"
}
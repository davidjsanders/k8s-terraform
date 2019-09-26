# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      nsg-allow-22-workers.tf
# Environments:   all
# Purpose:        Module to define the Azure network security group
#                 rule to enable ssh to the workerses.
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

resource "azurerm_network_security_rule" "k8s-nsgrules-workers" {
  count = length(var.nsg-rules-workers)

  name                   = var.nsg-rules-workers.*.name[count.index]
  priority               = "${200 + (10 * count.index)}"
  direction              = var.nsg-rules-workers.*.direction[count.index]
  access                 = var.nsg-rules-workers.*.access[count.index]
  protocol               = var.nsg-rules-workers.*.protocol[count.index]
  source_port_range      = var.nsg-rules-workers.*.source_port_range[count.index]
  destination_port_range = var.nsg-rules-workers.*.destination_port_range[count.index]
  source_address_prefix  = var.nsg-rules-workers.*.source_address_prefix[count.index]

  destination_address_prefix  = azurerm_subnet.k8s-subnet-worker.address_prefix
  resource_group_name         = azurerm_resource_group.k8s-rg.name
  network_security_group_name = azurerm_network_security_group.k8s-vnet-nsg.name
}


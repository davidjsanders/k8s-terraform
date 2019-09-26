# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      nsg-allow-22-jumpbox.tf
# Environments:   all
# Purpose:        Module to define the Azure network security group
#                 rule to enable ssh to the jumpboxes.
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

resource "azurerm_network_security_rule" "k8s-nsgrules-jumpbox" {
  count = length(var.nsg-rules-jumpbox)

  name                   = var.nsg-rules-jumpbox.*.name[count.index]
  priority               = "${100 + (count.index)}"
  direction              = var.nsg-rules-jumpbox.*.direction[count.index]
  access                 = var.nsg-rules-jumpbox.*.access[count.index]
  protocol               = var.nsg-rules-jumpbox.*.protocol[count.index]
  source_port_range      = var.nsg-rules-jumpbox.*.source_port_range[count.index]
  destination_port_range = var.nsg-rules-jumpbox.*.destination_port_range[count.index]
  source_address_prefix  = var.nsg-rules-jumpbox.*.source_address_prefix[count.index]

  destination_address_prefix  = azurerm_subnet.k8s-subnet-jumpbox.address_prefix
  resource_group_name         = azurerm_resource_group.k8s-rg.name
  network_security_group_name = azurerm_network_security_group.k8s-vnet-nsg.name
}


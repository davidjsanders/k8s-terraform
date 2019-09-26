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

resource "azurerm_network_security_rule" "k8s-nsgrule-allow-22-jumpbox" {
  name = format(
    "NSG-ALLOW-22-JUMPBOX-%s-%s%s",
    var.target,
    var.environ,
    local.l-random,
  )
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "Internet"
  destination_address_prefix  = azurerm_subnet.k8s-subnet-jumpbox.address_prefix
  resource_group_name         = azurerm_resource_group.k8s-rg.name
  network_security_group_name = azurerm_network_security_group.k8s-vnet-nsg.name
}


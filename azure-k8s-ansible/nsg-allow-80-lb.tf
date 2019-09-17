# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      nsg-allow-80-lb.tf
# Environments:   all
# Purpose:        Module to define the Azure network security group
#                 rule to allow port 80 to the load balancer.
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

resource "azurerm_network_security_rule" "k8s-nsgrule-allow-80-lb" {
  name                        = "${format("NSG-ALLOW-80-LB-%s-%s%s", var.target, var.environ, local.l-random)}"
  priority                    = 1010
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "${azurerm_subnet.k8s-subnet-worker.address_prefix}"
  resource_group_name         = "${azurerm_resource_group.k8s-rg.name}"
  network_security_group_name = "${azurerm_network_security_group.k8s-vnet-nsg.name}"
}

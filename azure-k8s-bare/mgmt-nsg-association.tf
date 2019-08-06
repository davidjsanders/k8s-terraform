# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      mgmt-nsg-association.tf
# Environments:   all
# Purpose:        Module to associate the management subnet to the
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

resource "azurerm_subnet_network_security_group_association" "mgmt-subnet-nsg-assoc" {
  subnet_id                 = "${module.mgt-subnet.id}"
  network_security_group_id = "${module.nsg-k8s.id}"
}
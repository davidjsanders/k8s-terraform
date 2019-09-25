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

resource "azurerm_subnet_network_security_group_association" "wrk-subnet-nsg-assoc" {
  subnet_id                 = "${module.wrk-subnet.id}"
  network_security_group_id = "${module.nsg-k8s.id}"
}
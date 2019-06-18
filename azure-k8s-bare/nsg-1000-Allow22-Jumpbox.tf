# -------------------------------------------------------------------
#
# Module:         terraform-reference-app/green
# Submodule:      nsg-rule-Allow22From10-62.tf
# Purpose:        Create a network security group rule to allow port 
#                 22 traffic in the Docker NSG from 10.62.71.0/24.
#
# ISSUES:         1. The inbound IP address is hard-coded. Needs to 
#                    change to a variable.
#
# Created on:     22 August 2018
# Created by:     David Sanders
# Creator email:  dsanderscanada@gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 22 Aug 2018  | David Sanders               | First release and
#                                            | valid creation of
#                                            | sample app.
# -------------------------------------------------------------------

locals {
  l-nsg-jumpbox-1-22 = "${replace(var.jumpbox-static-ip, "dc-prefix", var.dc-prefix)}"
}

module "nsg-Allow22-jumpbox" {
  source                      = "git::https://github.com/dsandersAzure/terraform-library.git//modules/nsg_rule?ref=0.6.0"
  name                        = "Allow22Jumpbox"
  resource-group-name         = "${module.resource-group.name}"
  network-security-group-name = "${module.nsg-k8s.name}"
  priority                    = "1000"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source-address-prefix       = "Internet"
  source-port-range           = "*"
  destination-address-prefix  = "${local.l-nsg-jumpbox-1-22}"
  destination-port-range      = "22"
}


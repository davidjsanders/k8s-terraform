# -------------------------------------------------------------------
#
# Module:         terraform-reference-app/green
# Submodule:      nsg-docker-rule-Allow22From10-62.tf
# Purpose:        Create a network security group rule to allow port 
#                 22 traffic in the Docker NSG from 10.62.71.0/24.
#
# ISSUES:         1. The inbound IP address is hard-coded. Needs to 
#                    change to a variable.
#
# Created on:     22 August 2018
# Created by:     David Sanders
# Creator email:  david.sanders2@loblaw.ca
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 22 Aug 2018  | David Sanders               | First release and
#                                            | valid creation of
#                                            | sample app.
# -------------------------------------------------------------------

module "nsg-docker-Allow22" {
  source                      = "git::https://github.com/dsandersAzure/terraform-library.git//modules/nsg_rule?ref=0.1.0"
  name                        = "Allow22"
  resource-group-name         = "${module.docker-resource-group.name}"
  network-security-group-name = "${module.nsg-docker.name}"
  priority                    = "1000"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source-address-prefix       = "Internet"
  source-port-range           = "*"
  destination-address-prefix  = "*"
  destination-port-range      = "22"
}


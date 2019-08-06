# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      nsg-Allow8080.tf
# Environments:   all
# Purpose:        Module to define NSG inbound rule for allowing port
#                 8080 traffic.
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

module "nsg-Allow8080" {
  source                      = "git::https://github.com/dsandersAzure/terraform-library.git//modules/nsg_rule?ref=0.8.0"
  name                        = "Allow8080"
  resource-group-name         = "${module.resource-group.name}"
  network-security-group-name = "${module.nsg-k8s.name}"
  priority                    = "120"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source-address-prefix       = "Internet"
  source-port-range           = "*"
  destination-address-prefix  = "*"
  destination-port-range      = "8080"
}


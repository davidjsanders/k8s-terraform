# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      nsg-Allow22-Jumpbox.tf
# Environments:   all
# Purpose:        Module to define NSG inbound rule for allowing port
#                 22 traffic only to the jumpbox.
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


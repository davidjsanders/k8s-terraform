# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      nsg.tf
# Environments:   all
# Purpose:        Module to define NSG for all vnet, subnet and node
#                 traffic.
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

# Define local variables for use in the module. **NOTE** Although the local
# variables are defined here they are GLOBAL in scope, hence the reason they
# all start with a unique name for the module, the l-... text.
#
locals {
  l-nsg-temp-name   = "${format("%s-%s%s", var.target, var.nsg-name, local.l-dev)}"
  l-nsg-name        = "${format("NSG-%s-%s%s", local.l-nsg-temp-name, var.environ, local.l-random)}"
}

module "nsg-k8s" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/nsg?ref=0.6.0"
  name                = "${local.l-nsg-name}"
  resource-group-name = "${module.resource-group.name}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

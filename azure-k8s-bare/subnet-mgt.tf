# -------------------------------------------------------------------
#
# Module:         terraform-reference-app/green
# Submodule:      subnet-k8s.tf
# Purpose:        Create a subnet for docker resources.
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

# Define local variables for use in the module. **NOTE** Although the local
# variables are defined here they are GLOBAL in scope, hence the reason they
# all start with a unique name for the module, the l-... text.
#
locals {
  l-mgt-snet-temp-name      = "${format("%s-%s%s", var.target, var.subnet-mgt-name, local.l-dev)}"
  l-mgt-snet-name           = "${format("SNET-%s-%s%s", local.l-mgt-snet-temp-name, var.environ, local.l-random)}"
  l-mgt-snet-address-prefix = "${replace(var.subnet-mgt-cidr, "dc-prefix", var.dc-prefix)}"
}

module "mgt-subnet" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/subnet?ref=0.5.1"
  name                = "${local.l-mgt-snet-name}"
  vnet-target-rg-name = "${module.resource-group.name}"
  vnet-target-name    = "${module.vnet-main.name}"
  nsg-id              = "${module.nsg-k8s.id}"
  address-prefix      = "${local.l-mgt-snet-address-prefix}"
}

# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      subnet-mgt.tf
# Environments:   all
# Purpose:        Module to define the management subnet in Azure.
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
# 05 Aug 2019  | David Sanders               | Simplify resource 
#              |                             | names and remove
#              |                             | deprecated code.
#              |                             | Update to remove
#              |                             | deprecated NSG
#              |                             | association.
# -------------------------------------------------------------------

# Define local variables for use in the module. **NOTE** Although the local
# variables are defined here they are GLOBAL in scope, hence the reason they
# all start with a unique name for the module, the l-... text.
#
locals {
  # l-mgt-snet-temp-name      = "${format("%s-%s%s", var.target, var.subnet-mgt-name, local.l-dev)}"
  l-mgt-snet-name           = "${format("SNET-MASTERS-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-mgt-snet-address-prefix = "${replace(var.subnet-mgt-cidr, "dc-prefix", var.dc-prefix)}"
}

module "mgt-subnet" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/subnet?ref=0.9.0"
  name                = "${local.l-mgt-snet-name}"
  vnet-target-rg-name = "${module.resource-group.name}"
  vnet-target-name    = "${module.vnet-main.name}"
  #nsg-id              = "${module.nsg-k8s.id}"
  address-prefix      = "${local.l-mgt-snet-address-prefix}"
}

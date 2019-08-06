# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      subnet-wrk.tf
# Environments:   all
# Purpose:        Module to define the workers subnet in Azure.
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
#              |                             | names.
# -------------------------------------------------------------------
# 06 Aug 2019  | David Sanders               | Remove deprecated route 
#              |                             | table ID and NSG id
#              |                             | from subnet
# -------------------------------------------------------------------

locals {
  # l-wrk-snet-temp-name      = "${format("%s-%s%s", var.target, var.subnet-wrk-name, local.l-dev)}"
  l-wrk-snet-name           = "${format("SNET-WORKERS-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-wrk-snet-address-prefix = "${replace(var.subnet-wrk-cidr, "dc-prefix", var.dc-prefix)}"
}

module "wrk-subnet" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/subnet?ref=0.9.0"
  name                = "${local.l-wrk-snet-name}"
  vnet-target-rg-name = "${module.resource-group.name}"
  vnet-target-name    = "${module.vnet-main.name}"
  address-prefix      = "${local.l-wrk-snet-address-prefix}"
}

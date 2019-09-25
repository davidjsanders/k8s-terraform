# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      virtual-network.tf
# Environments:   all
# Purpose:        Module to define the Azure virtual network used for
#                 mgm and worker subnets.
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

locals {
  l-vnet-name        = "${upper(format("VNET-%s-%s-%s%s", var.vnet-name, var.target, var.environ, local.l-random))}"
}

module "vnet-main" {
  source                    = "git::https://github.com/dsandersAzure/terraform-library.git//modules/virtual-network?ref=0.8.0"
  name                      = "${local.l-vnet-name}"
  resource-group-name       = "${module.resource-group.name}"
  cidr-block                = ["${var.vnet-cidr}"]
  location                  = "${var.location}"
  dns-servers               = []
  tags                      = "${var.tags}"
}


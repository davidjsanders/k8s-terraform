# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      pip-elb.tf
# Environments:   all
# Purpose:        Module to define external load balancer for the
#                 vnet to manage in-bound worker traffic.
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
  # l-pip-elb-temp-name = "${format("%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev)}"
  l-pip-elb-name      = "${format("PIP-LB-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-pip-elb-dns       = "${format("%s-%s%s", var.elb-prefix, var.elb-name, local.l-random)}"
}

module "pip-elb" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/publicip?ref=0.6.0"
  name                         = "${local.l-pip-elb-name}"
  resource-group-name          = "${module.resource-group.name}"
  public-ip-address-allocation = "static"
  domain-name-label            = "${local.l-pip-elb-dns}"
  sku                          = "Basic"
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}

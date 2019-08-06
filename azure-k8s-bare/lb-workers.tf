# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      lb-workers.tf
# Environments:   all
# Purpose:        Module to provision Azure load balancer (Layer 4)
#
# Created on:     25 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 25 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
# 05 Aug 2019  | David Sanders               | Simplify resource name
#              |                             | and add variable for
#              |                             | fe name
# -------------------------------------------------------------------

locals {
  l-lb-name      = "${format("LB-WORKERS-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-lb-fe-name      = "${format("LB-WORKERS-FE-%s-%s%s", var.target, var.environ, local.l-random)}"
}

module "lb-workers" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/lb-with-pip?ref=0.8.0"
  name                = "${local.l-lb-name}"
  frontend-name       = "${local.l-lb-fe-name}"
  sku                 = "Basic"
  public-ip-id        = "${module.pip-elb.id}"
  resource-group-name = "${module.resource-group.name}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      lb-workers-bepool.tf
# Environments:   all
# Purpose:        Module to provision Azure load balancer (Layer 4)
#                 backend pool
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
# -------------------------------------------------------------------

locals {
  # l-lb-bepool-temp-name = "${format("%s-%s%s", var.target, var.nic-name, local.l-dev)}"
  l-lb-bepool-name      = "${format("LB-WORKERS-BEPOOL-%s-%s%s", var.target, var.environ, local.l-random)}"
}

module "lb-workers-bepool" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/lb-bepool?ref=0.6.0"
  name                = "${local.l-lb-bepool-name}"
  resource-group-name = "${module.resource-group.name}"
  load-balancer-id    = "${module.lb-workers.id}"
}

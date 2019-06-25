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

locals {
  l-lb-temp-name = "${format("%s-%s%s", var.target, var.nic-name, local.l-dev)}"
  l-lb-name      = "${format("LB-WORKERS-%s-%s%s", local.l-lb-temp-name, var.environ, local.l-random)}"
}

module "lb-workers" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/lb-with-pip?ref=0.6.0"
  name                = "${local.l-lb-name}"
  frontend-name       = "fe-workers-fe"
  sku                 = "Standard"
  public-ip-id        = "${module.pip-elb.id}"
  resource-group-name = "${module.resource-group.name}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      lb-workers-probe.tf
# Environments:   all
# Purpose:        Module to provision Azure load balancer (Layer 4)
#                 probe
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

module "lb-workers-probe" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/lb-probe?ref=0.8.0"
  name                = "pro-workers-fe"
  protocol            = "tcp"
  port                = "80"
  interval-in-seconds = "5"
  number-of-probes    = "4"
  http-probe-path     = ""
  resource-group-name = "${module.resource-group.name}"
  load-balancer-id    = "${module.lb-workers.id}"
}

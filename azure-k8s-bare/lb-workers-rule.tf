# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      lb-workers-rule.tf
# Environments:   all
# Purpose:        Module to provision Azure load balancer (Layer 4)
#                 rule
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

module "lb-workers-80-rule" {
  source                  = "git::https://github.com/dsandersAzure/terraform-library.git//modules/lb-rule?ref=0.8.0"
  name                    = "lbr-80-80-workers-fe"
  resource-group-name     = "${module.resource-group.name}"
  load-balancer-id        = "${module.lb-workers.id}"
  probe-id                = "${module.lb-workers-probe.id}"
  bepool-id               = "${module.lb-workers-bepool.id}"
  frontend-config-name    = "fe-workers-fe"
  protocol                = "Tcp"
  frontend-port           = "80"
  backend-port            = "80"
  enable-floating-ip      = "false"
  idle-timeout-in-minutes = "5"
  load-distribution       = "Default"
}

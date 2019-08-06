# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      avset-workers.tf
# Environments:   all
# Purpose:        Module to provision Azure Availability Set for
#                 k8s workers.
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
# 05 Aug 2019  | David Sanders               | Simplify resource name
# -------------------------------------------------------------------

locals {
  # l-avs-wrk-temp-name = "${format("%s-%s%s", var.target, "WORKERS", local.l-dev)}"
  l-avs-wrk-name      = "${format("AVS-%s-WORKERS-%s%s", var.target, var.environ, local.l-random)}"
}

module "avs-workers" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/availability-set?ref=0.6.0"
  name                         = "${local.l-avs-wrk-name}"
  resource-group-name          = "${module.resource-group.name}"
  platform-fault-domain-count  = "3"
  platform-update-domain-count = "5"
  managed                      = true
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}
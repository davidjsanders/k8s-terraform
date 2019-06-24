# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      avset-k8s.tf
# Environments:   all
# Purpose:        Module to provision Azure Availability Set for
#                 k8s master(s) and jumpbox.
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

locals {
  l-avs-mstr-temp-name = "${format("%s-%s%s", var.target, "ENGINES", local.l-dev)}"
  l-avs-mstr-name      = "${format("AVS-%s-%s%s", local.l-avs-mstr-temp-name, var.environ, local.l-random)}"
}

module "avs-k8s" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/availability-set?ref=0.6.0"
  name                         = "${local.l-avs-mstr-name}"
  resource-group-name          = "${module.resource-group.name}"
  platform-fault-domain-count  = "3"
  platform-update-domain-count = "5"
  managed                      = true
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}

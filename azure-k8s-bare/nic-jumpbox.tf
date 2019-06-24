# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      nic-jumpbox.tf
# Environments:   all
# Purpose:        Module to provision a nic for the jumpbox.
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
  l-pnic-jumpbox-temp-name = "${format("%s-%s%s", var.target, var.nic-name, local.l-dev)}"
  l-pnic-jumpbox-1         = "${format("NIC-JUMPBOX-1-%s-%s%s", local.l-pnic-jumpbox-temp-name, var.environ, local.l-random)}"
  l-pnic-jumpbox-1-ip      = "${replace(var.jumpbox-static-ip, "dc-prefix", var.dc-prefix)}"
}

module "nic-jumpbox-1" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/public-nic?ref=0.6.0"
  name                = "${local.l-pnic-jumpbox-1}"
  resource-group-name = "${module.resource-group.name}"
  allocation          = "Static"
  subnet-id           = "${module.mgt-subnet.id}"
  public-ip-id        = "${module.pip-jumpbox.id}"
  private-ip-address  = "${local.l-pnic-jumpbox-1-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}


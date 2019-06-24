# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      nic-masters.tf
# Environments:   all
# Purpose:        Module to provision nics for the k8s master(s).
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
  l-pnic-temp-name    = "${format("%s-%s%s", var.target, var.nic-name, local.l-dev)}"
  l-pnic-master-1     = "${format("NIC-MASTER-1-%s-%s%s", local.l-pnic-temp-name, var.environ, local.l-random)}"
  l-pnic-master-1-ip  = "${replace(var.master-static-ip-1, "dc-prefix", var.dc-prefix)}"
}

module "nic-master-1" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/private-nic-static-ip?ref=0.6.0"
  name                = "${local.l-pnic-master-1}"
  resource-group-name = "${module.resource-group.name}"
  subnet-id           = "${module.mgt-subnet.id}"
  private-ip-address  = "${local.l-pnic-master-1-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

# module "nic-master-1" {
#   source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/public-nic?ref=0.6.0"
#   name                = "${local.l-pnic-master-1}"
#   resource-group-name = "${module.resource-group.name}"
#   allocation          = "Static"
#   subnet-id           = "${module.mgt-subnet.id}"
#   public-ip-id        = "${module.pip-master-1.id}"
#   private-ip-address  = "${local.l-pnic-master-1-ip}"
#   location            = "${var.location}"
#   tags                = "${var.tags}"
# }


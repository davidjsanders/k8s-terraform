# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      nic-workers.tf
# Environments:   all
# Purpose:        Module to provision nics for the k8s workers.
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
# 06 Aug 2019  | David Sanders               | Remove deprecated back 
#              |                             | end pool ID
# -------------------------------------------------------------------

locals {
  # l-nic-temp-name    = "${format("%s-%s%s", var.target, var.nic-name, local.l-dev)}"
  l-nic-worker-1     = "${format("NIC-WORKER-1-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-nic-worker-2     = "${format("NIC-WORKER-2-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-nic-worker-1-ip  = "${replace(var.worker-static-ip-1, "dc-prefix", var.dc-prefix)}"
  l-nic-worker-2-ip  = "${replace(var.worker-static-ip-2, "dc-prefix", var.dc-prefix)}"
}

module "nic-worker-1" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/private-nic-with-bepool-ip?ref=0.10.0"
  name                = "${local.l-nic-worker-1}"
  resource-group-name = "${module.resource-group.name}"
  subnet-id           = "${module.wrk-subnet.id}"
  ip-address          = "${local.l-nic-worker-1-ip}"
  allocation          = "Static"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

module "nic-worker-2" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/private-nic-with-bepool-ip?ref=0.10.0"
  name                = "${local.l-nic-worker-2}"
  resource-group-name = "${module.resource-group.name}"
  subnet-id           = "${module.wrk-subnet.id}"
  ip-address          = "${local.l-nic-worker-2-ip}"
  # bepool-ids          = "${module.lb-workers-bepool.id}"
  allocation          = "Static"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

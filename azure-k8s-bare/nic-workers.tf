locals {
  l-nic-temp-name    = "${format("%s-%s%s", var.target, var.nic-name, local.l-dev)}"
  l-nic-worker-1     = "${format("NIC-WORKER-1-%s-%s%s", local.l-nic-temp-name, var.environ, local.l-random)}"
  l-nic-worker-2     = "${format("NIC-WORKER-2-%s-%s%s", local.l-nic-temp-name, var.environ, local.l-random)}"
  l-nic-worker-1-ip  = "${replace(var.worker-static-ip-1, "dc-prefix", var.dc-prefix)}"
  l-nic-worker-2-ip  = "${replace(var.worker-static-ip-2, "dc-prefix", var.dc-prefix)}"
}

module "nic-worker-1" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/private-nic-static-ip"
  name                = "${local.l-nic-worker-1}"
  resource-group-name = "${module.resource-group.name}"
  subnet-id           = "${module.wrk-subnet.id}"
  private-ip-address  = "${local.l-nic-worker-1-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

module "nic-worker-2" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/private-nic-static-ip"
  name                = "${local.l-nic-worker-2}"
  resource-group-name = "${module.resource-group.name}"
  subnet-id           = "${module.wrk-subnet.id}"
  private-ip-address  = "${local.l-nic-worker-2-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

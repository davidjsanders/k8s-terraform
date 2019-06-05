locals {
  l-pnic-temp-name    = "${format("%s-%s%s", var.target, var.nic-name, local.l-dev)}"
  l-pnic-master-1     = "${format("NIC-MASTER-1-%s-%s%s", local.l-pnic-temp-name, var.environ, local.l-random)}"
  l-pnic-master-2     = "${format("NIC-MASTER-2-%s-%s%s", local.l-pnic-temp-name, var.environ, local.l-random)}"
  l-pnic-master-3     = "${format("NIC-MASTER-3-%s-%s%s", local.l-pnic-temp-name, var.environ, local.l-random)}"
  l-pnic-master-1-ip  = "${replace(var.master-static-ip-1, "dc-prefix", var.dc-prefix)}"
  l-pnic-master-2-ip  = "${replace(var.master-static-ip-2, "dc-prefix", var.dc-prefix)}"
  l-pnic-master-3-ip  = "${replace(var.master-static-ip-3, "dc-prefix", var.dc-prefix)}"
}

module "nic-master-1" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/public-nic"
  name                = "${local.l-pnic-master-1}"
  resource-group-name = "${module.resource-group.name}"
  allocation          = "Static"
  subnet-id           = "${module.mgt-subnet.id}"
  public-ip-id        = "${module.pip-master-1.id}"
  private-ip-address  = "${local.l-pnic-master-1-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

module "nic-master-2" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/public-nic"
  name                = "${local.l-pnic-master-2}"
  resource-group-name = "${module.resource-group.name}"
  allocation          = "Static"
  subnet-id           = "${module.mgt-subnet.id}"
  public-ip-id        = "${module.pip-master-2.id}"
  private-ip-address  = "${local.l-pnic-master-2-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

module "nic-master-3" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/public-nic"
  name                = "${local.l-pnic-master-3}"
  resource-group-name = "${module.resource-group.name}"
  allocation          = "Static"
  subnet-id           = "${module.mgt-subnet.id}"
  public-ip-id        = "${module.pip-master-3.id}"
  private-ip-address  = "${local.l-pnic-master-3-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}


locals {
  l-pnic-temp-name    = "${format("%s-%s%s", var.target, var.nic-name, local.l-dev)}"
  l-pnic-master-1     = "${format("NIC-MASTER-1-%s-%s%s", local.l-pnic-temp-name, var.environ, local.l-random)}"
  l-pnic-master-1-ip  = "${replace(var.master-static-ip-1, "dc-prefix", var.dc-prefix)}"
}

module "nic-master-1" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/private-nic-static-ip?ref=0.5.2"
  name                = "${local.l-pnic-master-1}"
  resource-group-name = "${module.resource-group.name}"
  subnet-id           = "${module.mgt-subnet.id}"
  private-ip-address  = "${local.l-pnic-master-1-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

# module "nic-master-1" {
#   source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/public-nic?ref=0.5.2"
#   name                = "${local.l-pnic-master-1}"
#   resource-group-name = "${module.resource-group.name}"
#   allocation          = "Static"
#   subnet-id           = "${module.mgt-subnet.id}"
#   public-ip-id        = "${module.pip-master-1.id}"
#   private-ip-address  = "${local.l-pnic-master-1-ip}"
#   location            = "${var.location}"
#   tags                = "${var.tags}"
# }


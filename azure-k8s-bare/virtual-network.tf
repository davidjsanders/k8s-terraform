locals {
  l-vnet-name        = "${upper(format("VNET-%s-%s-%s%s-%s", var.target, var.vnet-name, var.environ, local.l-dev, local.l-random))}"
}

module "vnet-main" {
  source                    = "git::https://github.com/dsandersAzure/terraform-library.git//modules/virtual-network?ref=0.2.0"
  name                      = "${local.l-vnet-name}"
  resource-group-name       = "${module.resource-group.name}"
  cidr-block                = ["${var.vnet-cidr}"]
  location                  = "${var.location}"
  dns-servers               = []
  tags                      = "${var.tags}"
}


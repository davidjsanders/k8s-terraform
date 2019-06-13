locals {
  l-wrk-snet-temp-name      = "${format("%s-%s%s", var.target, var.subnet-wrk-name, local.l-dev)}"
  l-wrk-snet-name           = "${format("SNET-%s-%s%s", local.l-wrk-snet-temp-name, var.environ, local.l-random)}"
  l-wrk-snet-address-prefix = "${replace(var.subnet-wrk-cidr, "dc-prefix", var.dc-prefix)}"
}

module "wrk-subnet" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/subnet?ref=0.5.1"
  name                = "${local.l-wrk-snet-name}"
  vnet-target-rg-name = "${module.resource-group.name}"
  vnet-target-name    = "${module.vnet-main.name}"
  nsg-id              = "${module.nsg-k8s.id}"
  address-prefix      = "${local.l-wrk-snet-address-prefix}"
}

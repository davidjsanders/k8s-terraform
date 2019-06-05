locals {
  l-docker-wrk-snet-temp-name      = "${format("%s-%s%s", var.target, var.subnet-docker-wrk-name, local.l-dev)}"
  l-docker-wrk-snet-name           = "${format("SNET-%s-%s%s", local.l-docker-wrk-snet-temp-name, var.environ, local.l-random)}"
  l-docker-wrk-snet-address-prefix = "${replace(var.subnet-docker-wrk-cidr, "dc-prefix", var.dc-prefix)}"
}

module "docker-wrk-subnet" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/subnet?ref=0.1.0"
  name                = "${local.l-docker-wrk-snet-name}"
  vnet-target-rg-name = "${data.azurerm_resource_group.vnet-resource-group.name}"
  vnet-target-name    = "${data.azurerm_virtual_network.vnet.name}"
  nsg-id              = "${module.nsg-docker.id}"
  address-prefix      = "${local.l-docker-wrk-snet-address-prefix}"
}

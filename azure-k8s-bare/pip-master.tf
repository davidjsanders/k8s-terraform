locals {
  l-pip-master-1-temp-name     = "${format("%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev)}"
  l-pip-master-1-name-1        = "${format("PIP-%s-%s-1%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev, var.environ, local.l-random)}"
  l-pip-master-1-dns-1          = "${format("dasander-k8slfd%s", local.l-random)}"
}

module "pip-master-1" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/publicip?ref=0.3.0"
  name                         = "${local.l-pip-master-1-name-1}"
  resource-group-name          = "${module.resource-group.name}"
  public-ip-address-allocation = "static"
  domain-name-label            = "${local.l-pip-master-1-dns-1}"
  sku                          = "Basic"
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}

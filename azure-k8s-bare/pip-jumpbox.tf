locals {
  l-pip-jumpbox-temp-name     = "${format("%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev)}"
  l-pip-jumpbox-name-1        = "${format("pip-jumpbox-%s-%s-1%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev, var.environ, local.l-random)}"
  l-pip-jumpbox-dns-1          = "${format("dasander-k8slfd-jump%s", local.l-random)}"
}

module "pip-jumpbox" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/publicip?ref=0.3.0"
  name                         = "${local.l-pip-jumpbox-name-1}"
  resource-group-name          = "${module.resource-group.name}"
  public-ip-address-allocation = "static"
  domain-name-label            = "${local.l-pip-jumpbox-dns-1}"
  sku                          = "Basic"
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}

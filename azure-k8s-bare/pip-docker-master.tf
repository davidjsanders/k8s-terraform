locals {
  l-pip-temp-name     = "${format("%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev)}"
  l-pip-name-1        = "${format("PIP-%s-%s-1%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev, var.environ, local.l-random)}"
  l-pip-name-2        = "${format("PIP-%s-%s-2%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev, var.environ, local.l-random)}"
  l-pip-name-3        = "${format("PIP-%s-%s-3%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev, var.environ, local.l-random)}"
  l-domain-name-label = "${format("%s-%s%s", lower(local.l-pip-temp-name), lower(var.environ), local.l-random)}"
#  l-pip-dns-1          = "${format("%s-%s-1%s", lower(var.target), lower(module.mgt-subnet.name), local.l-random)}"
  l-pip-dns-1          = "dasander-k8slfd"
  l-pip-dns-2          = "${format("%s-%s-2%s", lower(var.target), lower(module.mgt-subnet.name), local.l-random)}"
  l-pip-dns-3          = "${format("%s-%s-3%s", lower(var.target), lower(module.mgt-subnet.name), local.l-random)}"
}

module "pip-master-1" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/publicip?ref=0.1.0"
  name                         = "${local.l-pip-name-1}"
  resource-group-name          = "${module.resource-group.name}"
  public-ip-address-allocation = "static"
  domain-name-label            = "${local.l-pip-dns-1}"
  sku                          = "Basic"
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}

module "pip-master-2" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/publicip?ref=0.1.0"
  name                         = "${local.l-pip-name-2}"
  resource-group-name          = "${module.resource-group.name}"
  public-ip-address-allocation = "static"
  domain-name-label            = "${local.l-pip-dns-2}"
  sku                          = "Basic"
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}

module "pip-master-3" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/publicip?ref=0.1.0"
  name                         = "${local.l-pip-name-3}"
  resource-group-name          = "${module.resource-group.name}"
  public-ip-address-allocation = "static"
  domain-name-label            = "${local.l-pip-dns-3}"
  sku                          = "Basic"
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}

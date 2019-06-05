locals {
  l-avs-wrk-temp-name = "${format("%s-%s%s", var.target, "WORKERS", local.l-dev)}"
  l-avs-wrk-name      = "${format("AVS-%s-%s%s", local.l-avs-wrk-temp-name, var.environ, local.l-random)}"
}

module "avs-workers" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/availability-set?ref=0.3.0"
  name                         = "${local.l-avs-wrk-name}"
  resource-group-name          = "${module.resource-group.name}"
  platform-fault-domain-count  = "3"
  platform-update-domain-count = "5"
  managed                      = true
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}
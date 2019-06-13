locals {
  l-rg-temp-name  = "${format("%s-%s%s", var.target, var.resource-group-name, local.l-dev)}"
  l-rg-name       = "${format("RG-%s-%s%s", local.l-rg-temp-name, var.environ, local.l-random)}"
}

module "resource-group" {
  source          = "git::https://github.com/dsandersAzure/terraform-library.git//modules/rg?ref=0.5.2"
  name            = "${local.l-rg-name}"
  location        = "${var.location}"
  tags            = "${var.tags}"
}

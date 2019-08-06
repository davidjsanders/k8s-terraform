# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      pip-jumpbox.tf
# Environments:   all
# Purpose:        Module to define public IP for the jumpbox.
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
# 05 Aug 2019  | David Sanders               | Simplify resource 
#              |                             | names.
# -------------------------------------------------------------------
# 06 Aug 2019  | David Sanders               | Change deprecated 
#              |                             | public ip address
#              |                             | allocation to
#              |                             | allocation method.
# -------------------------------------------------------------------

locals {
  # l-pip-jumpbox-temp-name     = "${format("%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev)}"
  l-pip-jumpbox-name-1        = "${format("PIP-JUMPBOX-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-pip-jumpbox-dns-1          = "${format("%s-%s-jump%s", var.elb-prefix, var.elb-name, local.l-random)}"
}

module "pip-jumpbox" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/publicip?ref=0.11.0"
  name                = "${local.l-pip-jumpbox-name-1}"
  resource-group-name = "${module.resource-group.name}"
  allocation-method   = "Static"
  domain-name-label   = "${local.l-pip-jumpbox-dns-1}"
  sku                 = "Basic"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      resource-group.tf
# Environments:   all
# Purpose:        Module to define the Azure Resource Group used to
#                 contain all resources.
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

locals {
  # l-rg-temp-name  = "${format("%s-%s%s", var.target, var.resource-group-name, local.l-dev)}"
  l-rg-name       = "${format("RG-%s-%s-%s%s", var.resource-group-name, var.target, var.environ, local.l-random)}"
}

module "resource-group" {
  source          = "git::https://github.com/dsandersAzure/terraform-library.git//modules/rg?ref=0.6.0"
  name            = "${local.l-rg-name}"
  location        = "${var.location}"
  tags            = "${var.tags}"
}

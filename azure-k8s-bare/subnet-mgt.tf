# -------------------------------------------------------------------
#
# Module:         terraform-reference-app/green
# Submodule:      subnet-docker.tf
# Purpose:        Create a subnet for docker resources.
#
# Created on:     22 August 2018
# Created by:     David Sanders
# Creator email:  david.sanders2@loblaw.ca
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 22 Aug 2018  | David Sanders               | First release and
#                                            | valid creation of
#                                            | sample app.
# -------------------------------------------------------------------

# Define local variables for use in the module. **NOTE** Although the local
# variables are defined here they are GLOBAL in scope, hence the reason they
# all start with a unique name for the module, the l-... text.
#
locals {
  l-docker-mgt-snet-temp-name      = "${format("%s-%s%s", var.target, var.subnet-docker-mgt-name, local.l-dev)}"
  l-docker-mgt-snet-name           = "${format("SNET-%s-%s%s", local.l-docker-mgt-snet-temp-name, var.environ, local.l-random)}"
  l-docker-mgt-snet-address-prefix = "${replace(var.subnet-docker-mgt-cidr, "dc-prefix", var.dc-prefix)}"
}

module "docker-mgt-subnet" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/subnet?ref=0.1.0"
  name                = "${local.l-docker-mgt-snet-name}"
  vnet-target-rg-name = "${data.azurerm_resource_group.vnet-resource-group.name}"
  vnet-target-name    = "${data.azurerm_virtual_network.vnet.name}"
  nsg-id              = "${module.nsg-docker.id}"
  address-prefix      = "${local.l-docker-mgt-snet-address-prefix}"
}

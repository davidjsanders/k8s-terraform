# -------------------------------------------------------------------
#
# Module:         terraform-reference-app/green
# Submodule:      nsg-k8s.tf
# Purpose:        Create a network security group to be used 
#                 on the Docker subnet to restrict traffic
#                 flows inbound or outbound (E<>W).
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
  l-nsg-temp-name   = "${format("%s-%s%s", var.target, var.nsg-name, local.l-dev)}"
  l-nsg-name        = "${format("NSG-%s-%s%s", local.l-nsg-temp-name, var.environ, local.l-random)}"
}

module "nsg-k8s" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/nsg?ref=0.3.0"
  name                = "${local.l-nsg-name}"
  resource-group-name = "${module.resource-group.name}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

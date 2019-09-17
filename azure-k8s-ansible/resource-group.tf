# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      resource-group.tf
# Environments:   all
# Purpose:        Module to define the Azure Resource Group used to
#                 contain all resources.
#
# Created on:     08 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 08 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

resource "azurerm_resource_group" "k8s-rg" {
  name = format(
    "RG-%s-%s-%s%s",
    var.resource-group-name,
    var.target,
    var.environ,
    local.l-random,
  )
  location = var.location
  tags     = var.tags
}


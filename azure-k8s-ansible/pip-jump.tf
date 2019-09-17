# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      pip-jump.tf
# Environments:   all
# Purpose:        Module to define the Azure jumpbox puplic IP.
#
# Created on:     10 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 10 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

resource "azurerm_public_ip" "k8s-pip-jump" {
  allocation_method = "Static"
  location          = var.location
  name = format(
    "PIP-%s-JUMP-%s-%s%s",
    var.vnet-name,
    var.target,
    var.environ,
    local.l-random,
  )
  resource_group_name = azurerm_resource_group.k8s-rg.name
  sku                 = "Basic"

  tags = var.tags
}

